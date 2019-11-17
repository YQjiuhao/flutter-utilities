// Function
/// 公司：遵义极客信息科技有限责任公司
/// 作者：Biao~~
/// 时间：2019-09-09
/// 
import 'dart:ui';
import 'package:flutter/cupertino.dart';

class Adapt {
  static MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
  static double _width = mediaQuery.size.width;
  static double _height = mediaQuery.size.height;
  static double _statusH = mediaQuery.padding.top;
  static double _botbarH = mediaQuery.padding.bottom;
  static double _pixelRatio = mediaQuery.devicePixelRatio;
  static var _ratio;

  static init(number) {
    int uiwidth = number is int ? number : 750;
    _ratio = _width / uiwidth;
  }

  static px(number) {
    if (!(_ratio is double || _ratio is int)) init(750);
    return _ratio * number;
  }

  static onepx() {
    return 1 / _pixelRatio;
  }

  static screenW() {
    return _width;
  }

  static screenH() {
    return _height;
  }

  static padTopH() {
    return _statusH;
  }

  static padBotH() {
    return _botbarH;
  }
}
