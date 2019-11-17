// Function
/// 公司：遵义极客信息科技有限责任公司
/// 作者：Biao~~
/// 时间：2019-09-09
/// 
import 'package:flutter/widgets.dart';
import '../widgets/toast.dart';
import '../widgets/progress_hud.dart';

class UX {
  final List<ProgressHUD> huds = [];

  final List<BuildContext> contexts = [];

  static Toast _toast = Toast();

  static void toast(String message) {
    UX ux = UX.share();
    assert(ux.contexts?.isNotEmpty == true);
    _toast.show(ux.contexts.last, text: message);
  }

  static void error({String text}) {
    UX ux = UX.share();
    ux.huds.last.error(text: text);
  }

  static removeToast() {
    _toast.dismiss();
  }

  static void show({String text}) {
    UX ux = UX.share();
    ux.huds.last.show(text: text);
  }

  static void hidden() {
    UX ux = UX.share();
    ux.huds.last.done();
  }

  factory UX() => share();
  UX._();
  static UX _instance;
  static UX share() {
    if (_instance == null) {
      _instance = UX._();
    }
    return _instance;
  }
}
