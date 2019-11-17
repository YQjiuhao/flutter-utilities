// Function
/// 公司：遵义极客信息科技有限责任公司
/// 作者：Biao~~
/// 时间：2019-09-09
/// 
import 'package:flutter/material.dart';
import 'dart:async';

class CupertinoSwipeBackObserver extends NavigatorObserver {
  static Completer promise;
  @override
  void didStartUserGesture(Route route, Route previousRoute) {
    promise = Completer();
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    promise.complete();
  }
}
