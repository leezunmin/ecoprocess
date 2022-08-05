import 'package:flutter/widgets.dart';

class AppEdgeInsets {
  AppEdgeInsets._();
  static const zero = EdgeInsets.all(0);
  static const all4 = EdgeInsets.all(4);
  static const all8 = EdgeInsets.all(8);
  static const all16 = EdgeInsets.all(16);
  static const all24 = EdgeInsets.all(24);
  static const all32 = EdgeInsets.all(32);
  static const all40 = EdgeInsets.all(40);
  static const top4 = EdgeInsets.only(top: 4);
  static const top8 = EdgeInsets.only(top: 8);
  static const top16 = EdgeInsets.only(top: 16);
  static const top24 = EdgeInsets.only(top: 24);
  static const top32 = EdgeInsets.only(top: 32);
  static const bottom4 = EdgeInsets.only(bottom: 4);
  static const bottom8 = EdgeInsets.only(bottom: 8);
  static const bottom16 = EdgeInsets.only(bottom: 16);
  static const bottom24 = EdgeInsets.only(bottom: 24);
  static const bottom32 = EdgeInsets.only(bottom: 32);
  static const bottom40 = EdgeInsets.only(bottom: 40);
  static const bottom48 = EdgeInsets.only(bottom: 48);
  static const bottom56 = EdgeInsets.only(bottom: 56);
  static const leftZero = EdgeInsets.only(left: 0);
  static const left4 = EdgeInsets.only(left: 4);
  static const left8 = EdgeInsets.only(left: 8);
  static const left16 = EdgeInsets.only(left: 16);
  static const left24 = EdgeInsets.only(left: 24);
  static const left32 = EdgeInsets.only(left: 32);
  static const right4 = EdgeInsets.only(right: 4);
  static const right8 = EdgeInsets.only(right: 8);
  static const right16 = EdgeInsets.only(right: 16);
  static const right24 = EdgeInsets.only(right: 24);
  static const right32 = EdgeInsets.only(right: 32);
  static const horizontal4 = EdgeInsets.symmetric(horizontal: 4);
  static const horizontal8 = EdgeInsets.symmetric(horizontal: 8);
  static const horizontal16 = EdgeInsets.symmetric(horizontal: 16);
  static const horizontal24 = EdgeInsets.symmetric(horizontal: 24);
  static const horizontal32 = EdgeInsets.symmetric(horizontal: 32);
  static const horizontal40 = EdgeInsets.symmetric(horizontal: 40);
  static const vertical4 = EdgeInsets.symmetric(
    vertical: 4,
  );
  static const vertical8 = EdgeInsets.symmetric(
    vertical: 8,
  );
  static const vertical12 = EdgeInsets.symmetric(
    vertical: 12,
  );
  static const vertical16 = EdgeInsets.symmetric(
    vertical: 16,
  );
  static const vertical24 = EdgeInsets.symmetric(vertical: 24);
  static const vertical20 = EdgeInsets.symmetric(vertical: 20);
  static const vertical32 = EdgeInsets.symmetric(vertical: 32);
  static const vertical40 = EdgeInsets.symmetric(vertical: 40);
}

class AppSpacers {
  AppSpacers._();
  static const zero = SizedBox(height: 0, width: 0);
  static const height4 = SizedBox(height: 4);
  static const height8 = SizedBox(height: 8);
  static const height12 = SizedBox(height: 12);
  static const height14 = SizedBox(height: 14);
  static const height16 = SizedBox(height: 16);
  static const height20 = SizedBox(height: 20);
  static const height24 = SizedBox(height: 24);

  static const height30 = SizedBox(height: 30);
  static const height32 = SizedBox(height: 32);
  static const height40 = SizedBox(height: 40);
  static const height48 = SizedBox(height: 48);
  static const height50 = SizedBox(height: 50);
  static const height64 = SizedBox(height: 64);
  static const height80 = SizedBox(height: 80);
  static const width4 = SizedBox(width: 4);
  static const width8 = SizedBox(width: 8);
  static const width16 = SizedBox(width: 16);
  static const width18 = SizedBox(width: 18);
  static const width24 = SizedBox(width: 24);
  static const width32 = SizedBox(width: 32);
  static const width40 = SizedBox(width: 40);
  static const width48 = SizedBox(width: 48);
  static const width60 = SizedBox(width: 60);
  static const width70 = SizedBox(width: 70);
}

class AppBorderRadius {
  AppBorderRadius._();

  static final circular4 = BorderRadius.circular(4);
  static final circular8 = BorderRadius.circular(8);
  static final circular16 = BorderRadius.circular(16);
  static final circular24 = BorderRadius.circular(24);
  static final circular32 = BorderRadius.circular(32);
  static final circular40 = BorderRadius.circular(40);
  static final circular48 = BorderRadius.circular(48);
  static final circularMax = BorderRadius.circular(double.maxFinite);
  static final circularZero = BorderRadius.circular(0);
  static const verticalTop24 = BorderRadius.vertical(top: Radius.circular(24));

  static const verticalTop8 = BorderRadius.vertical(top: Radius.circular(8));
  static const verticalBottom8 =
  BorderRadius.vertical(bottom: Radius.circular(8));
  static const horizontalLeft24 =
  BorderRadius.horizontal(left: Radius.circular(24));
  static const horizontalLeft8 =
  BorderRadius.horizontal(left: Radius.circular(8));
  static const horizontalRight8 =
  BorderRadius.horizontal(right: Radius.circular(8));

  static const withoutTopLeft8 = BorderRadius.only(
      topRight: Radius.circular(8),
      bottomLeft: Radius.circular(8),
      bottomRight: Radius.circular(8));
  static const TopLeft24 = BorderRadius.only(
      topLeft: Radius.circular(24),
      bottomLeft: Radius.circular(8),
      bottomRight: Radius.circular(8));
  static const withoutTopRigth8 = BorderRadius.only(
      topLeft: Radius.circular(8),
      bottomLeft: Radius.circular(8),
      bottomRight: Radius.circular(8));
}

class AppTokens {
  AppTokens._();
  static const zero = 0;
  static const k4 = 4.0;
  static const k8 = 8.0;
  static const k16 = 16.0;
  static const k24 = 24.0;
  static const k32 = 32.0;
  static const k40 = 40.0;
  static const k48 = 48.0;
  static const k56 = 56.0;
  static const k64 = 64.0;
  static const k72 = 72.0;
  static const k80 = 80.0;
  static const k88 = 88.0;
  static const k96 = 96.0;
  static const k104 = 104.0;
  static const k112 = 112.0;
  static const k120 = 120.0;
}

class AppTypoTokens {
  AppTypoTokens._();
  static const k96 = 96.0;
  static const k60 = 60.0;
  static const k48 = 48.0;
  static const k34 = 34.0;
  static const k24 = 24.0;
  static const k20 = 20.0;
  static const k16 = 16.0;
  static const k14 = 14.0;
  static const k12 = 12.0;
  static const k10 = 10.0;
  static const k8 = 8.0;
}
