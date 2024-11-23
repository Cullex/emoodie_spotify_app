import 'package:flutter/material.dart';

class Dimensions {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static late double iconSize24;

  static late double safeAreaHorizontal;
  static late double safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  static late double height20;
  static late double height30;
  static late double height40;
  static late double width20;
  static late double width30;
  static late double width45;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    iconSize24 = blockSizeVertical * 2;

    safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - safeAreaVertical) / 100;
    height20 = screenHeight / 42.3;
    height30 = screenHeight / 28.2;
    height40 = screenHeight / 21.15;
    width20 = screenWidth / 41.5;
    width30 = screenWidth / 27.6;
    width45 = screenWidth / 18.4;
  }
}
