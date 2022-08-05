import 'dart:math';
import 'package:darty_json/darty_json.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';


const slashUSDT = "/USDT";

final passwordRegex =
RegExp(r'^(?=.*\d)(?=.*[a-zA-Z])(?=.*[^\w\d\s:])([^\s]){8,32}$');

void snack(BuildContext context, String message,
    {int durationSeconds = 1, SnackBarAction? action}) {
  context.snack(message, durationSeconds: durationSeconds, action: action);
}

extension ContextExt on BuildContext {
  NavigatorState get navigator => Navigator.of(this);

  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);

  snack(String message, {int durationSeconds = 1, SnackBarAction? action}) {
    messenger.removeCurrentSnackBar();
    messenger.showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: durationSeconds),
      action: action,
    ));
  }

  bool get isMobile => MediaQuery.of(this).size.width < 1024;
}

extension numExt on num {
  double round(int places) {
    num mod = pow(10.0, places);
    return ((this * mod).round().toDouble() / mod);
  }

  double floorPoints(int floatingPoints) {
    final p = pow(10.0, floatingPoints);

    return (this * p).floor() / p;
  }


  double floorCurrency(String symbol) {
    var doubleValue = toDouble();

    if (symbol.toUpperCase().endsWith("USDT")) {
      return doubleValue.floorPoints(2);
    } else {
      return doubleValue;
    }
  }

}

extension StringExt on String {
  double floorCurrency(String symbol) {
    var doubleValue =
        double.tryParse(replaceAll(",", "").replaceAll(" ", "")) ?? 0.0;

    return doubleValue.floorCurrency(symbol);
  }

  String get symbolSlashUSDT => replaceAll("USDT", "/USDT");

  int? parseInt() => int.tryParse(replaceAll(",", "").replaceAll(" ", ""));

  double? parseDouble() =>
      double.tryParse(replaceAll(",", "").replaceAll(" ", ""));

}

extension doubleExt on double {
  double round(int places) {
    num mod = pow(10.0, places);
    return ((this * mod).round().toDouble() / mod);
  }

  Color get profitColor {
    if (this == 0) {
      return Colors.black87;
    } else if (this > 0) {
      return Colors.red;
    } else {
      return Colors.blue;
    }
  }
}


extension StreamExt<T> on Stream<T> {
  BehaviorSubject<T> asSubject() => BehaviorSubject<T>()..addStream(this);
}

extension DurationExt on Duration {
  String get text {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(inSeconds.remainder(60));
    return "${inHours > 0 ? twoDigits(inHours) + ':' : ''}$twoDigitMinutes:$twoDigitSeconds";
  }
}

typedef IDGetter<T> = dynamic Function(T e);

extension BehaviorSubjectExt<T> on BehaviorSubject<List<T>> {
  void replaceListItem(T element, IDGetter<T> idGetter) {
    final listValue = value;
    final index = listValue.indexWhere((e) => idGetter(element) == idGetter(e));

    if (index > -1) {
      listValue[index] = element;
      value = listValue;
    }
  }
}

// StreamingSharedPreferences get preference =>
//     Get.find<StreamingSharedPreferences>();

Json convertToJson(dynamic obj) {
  if (obj is Json) {
    return obj;
  } else if (obj is String) {
    return Json.fromString(obj);
  } else {
    return Json.fromDynamic(obj);
  }
}

String getErrorMessage(dynamic error) {
  if (error is DioError) {
    error = error.error;
  }

  if (error is String) {
    return error;
  }

  if (error is Map && error.containsKey("message")) {
    return error["message"];
  }

  return error.toString();
}

bool alertIfTextFieldEmpty(
    BuildContext context, TextEditingController field, String fieldName) {
  if (field.text.trim().isEmpty) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text("$fieldName 을 입력하세요", style: TextStyle()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("확인", style: TextStyle()),
            )
          ],
        ));

    return true;
  }

  return false;
}

void alertMessage(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message, style: TextStyle()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("확인", style: TextStyle()),
          )
        ],
      ));
}

Widget toolbarPadding(Widget child) {
  return Padding(
    padding: EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
    child: child,
  );
}

Widget searchPadding(Widget child) {
  return Padding(
    padding: EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 8),
    child: child,
  );
}

Widget filterPadding(Widget child) {
  return Padding(
      padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 12),
      child: child);
}

const double fieldHeight = 44;
const double fieldWidth = 150;


const host = String.fromEnvironment('host', defaultValue: 'trade.acornbit.com');
bool get isDev => host == "dev.acornbit.com";
bool get isLive => host == "trade.acornbit.com";
