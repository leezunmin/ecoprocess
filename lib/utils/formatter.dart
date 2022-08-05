import 'package:intl/intl.dart';

//1.23M etc..
String formatSimpleNum(num _number) => NumberFormat.compact().format(_number);

String formatyMMMMD(DateTime date) => DateFormat.yMMMMd().format(date);

String formatyMD(DateTime date) => DateFormat.yQQQ().format(date);

String formatyyMMddHHmm(DateTime date) {
  DateFormat dateFormat = DateFormat('yy.MM.dd HH:mm', 'ko_KR');
  String formatedDateString = dateFormat.format(date);

  return formatedDateString;
}

String formatMMddHHmm(DateTime date) {
  DateFormat dateFormat = DateFormat('MM.dd HH:mm', 'ko_KR');
  String formatedDateString = dateFormat.format(date);

  return formatedDateString;
}

String formatABBRMONTH(DateTime date) {
  DateFormat dateFormat = DateFormat(DateFormat.ABBR_MONTH);
  String formatedDateString = dateFormat.format(date);

  return formatedDateString;
}

String formatyyMMdd(DateTime date) {
  DateFormat dateFormat = DateFormat('yy.MM.dd', 'ko_KR');
  String formatedDateString = dateFormat.format(date);

  return formatedDateString;
}

String formatyyyyMMdd(DateTime date) {
  DateFormat dateFormat = DateFormat('yyyy.MM.dd', 'ko_KR');
  String formatedDateString = dateFormat.format(date);

  return formatedDateString;
}

String formathhmm(DateTime date) {
  DateFormat dateFormat = DateFormat('hh:mm', 'ko_KR');
  String formatedDateString = dateFormat.format(date);

  return formatedDateString;
}

DateTime dateFromyyyyMMdd(String dateString) {
  DateFormat dateFormat = DateFormat('yyyy.MM.dd', 'ko_KR');
  DateTime date = dateFormat.parse(dateString);
  return date;
}

DateTime dateFromyyyyMMddHHmm(String dateString) {
  DateFormat dateFormat = DateFormat('yyyy.MM.dd HH:mm ', 'ko_KR');
  DateTime date = dateFormat.parse(dateString);
  return date;
}

String formatSimpleTime(int sec) {
  const _1M = 60;
  const _1H = _1M * 60;
  const _1D = _1H * 24;
  const _1W = _1D * 7;
  const _1m = _1D * 30;
  const _1Y = _1D * 365;
  if (sec < _1M) {
    return '$sec sec';
  } else if (sec < _1H) {
    return '${(sec / _1M).round()} min';
  } else if (sec < _1D) {
    return '${(sec / _1H).round()} hour';
  } else if (sec < _1W) {
    return '${(sec / _1D).round()} day';
  } else if (sec < _1m) {
    return '${(sec / _1W).round()} week';
  } else if (sec < _1Y) {
    return '${(sec / _1m).round()} month';
  } else {
    return '${(sec / _1Y).round()} year';
  }
}
