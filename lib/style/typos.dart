// import 'package:application/generated/fonts.gen.dart';
// import 'package:application/styles/tokens.dart';

import 'package:eco_process/style/tokens.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

final appSimpleTextTheme = TextTheme(
  headline1: TextStyle(
      fontSize: AppTypoTokens.k96,
      fontWeight: FontWeight.w300,
      color: AppColors.gray[60]),
  headline2: TextStyle(
      fontSize: AppTypoTokens.k60,
      fontWeight: FontWeight.w300,
      color: AppColors.gray[60]),
  headline3: TextStyle(
      fontSize: AppTypoTokens.k48,
      fontWeight: FontWeight.w400,
      color: AppColors.gray[60]),
  headline4: TextStyle(
      fontSize: AppTypoTokens.k34,
      fontWeight: FontWeight.w400,
      color: AppColors.gray[60]),
  headline5: TextStyle(
      fontSize: AppTypoTokens.k24,
      fontWeight: FontWeight.w400,
      color: AppColors.gray[60]),
  headline6: TextStyle(
      fontSize: AppTypoTokens.k20,
      fontWeight: FontWeight.w500,
      color: AppColors.gray[60]),
  subtitle1: TextStyle(
      fontSize: AppTypoTokens.k16,
      fontWeight: FontWeight.w400,
      color: AppColors.gray[50]),
  subtitle2: TextStyle(
      fontSize: AppTypoTokens.k14,
      fontWeight: FontWeight.w500,
      color: AppColors.gray[50]),
  bodyText1:
  const TextStyle(fontSize: AppTypoTokens.k16, fontWeight: FontWeight.w400),
  bodyText2:
  const TextStyle(fontSize: AppTypoTokens.k14, fontWeight: FontWeight.w400),
  button:
  const TextStyle(fontSize: AppTypoTokens.k14, fontWeight: FontWeight.w500),
  caption: TextStyle(
      fontSize: AppTypoTokens.k12,
      fontWeight: FontWeight.w400,
      color: AppColors.gray[40]),
  overline: TextStyle(
      fontSize: AppTypoTokens.k10,
      fontWeight: FontWeight.w400,
      color: AppColors.gray[40]),
);

// class DesignCourseAppTheme {
class AppTypos {
  AppTypos._();

  //BeMy
  /*static const TextStyle notoMedium = TextStyle(
    // Caption -> caption
    //fontFamily: 'NotoSansKR',
    fontFamily: 'NotoSansKR-Medium',
    fontWeight: FontWeight.w500,
    fontSize: 22,
    letterSpacing: -1.5,
    // color: lightText, // was li
    color: Color(0xff374553)
  );*/

  /*static const TextStyle noto_Medium = TextStyle(
    fontFamily: FontFamily.notoSansKRMedium,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: -1,
    color: AppColors.nt_medium, // was li
    //color: Color(0xff374553)
  );

  static const TextStyle noto_light = TextStyle(
    fontFamily: FontFamily.notoSansKRLight,
    fontWeight: FontWeight.w300,
    fontSize: 14,
    letterSpacing: -1,
    color: AppColors.nt_light, // was li
    //color: Color(0xff374553)
  );

  static const TextStyle noto_regular = TextStyle(
    fontFamily: FontFamily.notoSansKRRegular,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -1,
    // color: lightText, // was li
    //color: Color(0xff374553)
  );

// Montserrat

  static const TextStyle mont_medium = TextStyle(
    fontFamily: FontFamily.montserratMedium,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    // letterSpacing: -1,
    color: AppColors.lightGrey, // was li
    //color: Color(0xff374553)
  );

  static const TextStyle mont_regular = TextStyle(
      fontFamily: FontFamily.montserratRegular,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      // letterSpacing: -1,
      // color: lightGrey, // was li
      color: Color(0xff646F7C));*/

/* static const TextStyle bemyNoto = TextStyle(
    // Caption -> caption
      fontFamily: 'NotoSansKR-Medium',
      fontWeight: FontWeight.w400,
      fontSize: 22,
      letterSpacing: 0.0,
      // color: lightText, // was li
      color: Color(0xff374553),
      fontStyle:
  );*/

}
