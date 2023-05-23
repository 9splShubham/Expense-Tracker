import 'package:expense_tracker/core/app_color.dart';
import 'package:flutter/material.dart';

class AppFonts {
  static const avenirRegular = 'AvenirRegular';

  ///White

  static const regular = TextStyle(
      fontFamily: avenirRegular,
      fontWeight: FontWeight.w400,
      color: AppColor.colorWhite);
  static const bold = TextStyle(
      fontFamily: avenirRegular,
      fontWeight: FontWeight.w700,
      color: AppColor.colorWhite);
  static const semiBold = TextStyle(
      fontFamily: avenirRegular,
      fontWeight: FontWeight.w600,
      color: AppColor.colorWhite);
  static const mediumBold = TextStyle(
      fontFamily: avenirRegular,
      fontWeight: FontWeight.w500,
      color: AppColor.colorWhite);

  ///colorBlue

  static final regularBlue = regular.copyWith(color: AppColor.colorBlue);
  static final boldBlue = bold.copyWith(color: AppColor.colorBlue);
  static final semiBoldBlue = semiBold.copyWith(color: AppColor.colorBlue);
  static final mediumBoldBlue = mediumBold.copyWith(color: AppColor.colorBlue);

  ///colorBlack

  static final regularBlack = regular.copyWith(color: AppColor.colorBlack);
  static final boldBlack = bold.copyWith(color: AppColor.colorBlack);
  static final semiBoldBlack = semiBold.copyWith(color: AppColor.colorBlack);
  static final mediumBoldBlack =
      mediumBold.copyWith(color: AppColor.colorBlack);

  ///colorGrey

  static final regularGrey = regular.copyWith(color: AppColor.colorGrey);
  static final boldGrey = bold.copyWith(color: AppColor.colorGrey);
  static final semiBoldGrey = semiBold.copyWith(color: AppColor.colorGrey);
  static final mediumBoldGrey = mediumBold.copyWith(color: AppColor.colorGrey);
}

/// A [getTextStyle] This Method Use to getTextStyle
TextStyle getTextStyle(TextStyle mainTextStyle, double size) {
  return mainTextStyle.copyWith(fontSize: size);
}

/// A [getTextStyleFontWeight] This Method Use to get Text Style with FontWeight
TextStyle getTextStyleFontWeight(
    TextStyle mainTextStyle, double size, FontWeight fontWeight) {
  return mainTextStyle.copyWith(fontSize: size, fontWeight: fontWeight);
}
