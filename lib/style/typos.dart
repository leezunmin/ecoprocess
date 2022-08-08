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


class AppTypos {
  AppTypos._();

}
