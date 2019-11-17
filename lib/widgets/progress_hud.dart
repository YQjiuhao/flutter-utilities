// Function
/// 公司：遵义极客信息科技有限责任公司
/// 作者：Biao~~
/// 时间：2019-09-09
///
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class _HUDIndicator {
  _HUDIndicator({@required this.indicator, this.loadText});

  /// 提示控件
  Widget indicator;

  /// 提示文字
  String loadText;
}

class _ProgressBox extends StatefulWidget {
  _ProgressBox({Key key, @required _HUDIndicator hudInd})
      : assert(hudInd != null),
        this.hudInd = hudInd,
        super(key: key);

  /// 提示控件
  final _HUDIndicator hudInd;

  @override
  _ProgressBoxState createState() => _ProgressBoxState();
}

class _ProgressBoxState extends State<_ProgressBox> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String loadText = widget.hudInd.loadText;

    List<Widget> child = [
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: widget.hudInd.indicator,
      )
    ];
    if (loadText != null && loadText.isNotEmpty) {
      child.add(Text(loadText));
    }

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Center(
          child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: child,
        ),
      )),
    );
  }
}

/// 默认加载提示动画
class DefaultIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator();
    // return AnimatedRotationBox(
    //   duration: Duration(milliseconds: 800),
    //   child: GradientCircularProgressIndicator(
    //     radius: 15.0,
    //     colors: [Colors.red, Colors.red[50]],
    //     value: .8,
    //     backgroundColor: Colors.transparent,
    //     strokeCapRound: true,
    //   ),
    // );
  }
}

class ProgressHUD extends StatefulWidget {
  ProgressHUD({Key key}) : super(key: key);

  final ProgressHUDState _state = ProgressHUDState();

  show({Widget indicator, String text}) {
    _state.show(indicator: indicator ?? DefaultIndicator(), text: text);
  }

  success({Widget indicator, String text, int duration = 600}) {
    _state.success(indicator: indicator, text: text, duration: duration);
  }

  error({Widget indicator, String text, int duration = 600}) {
    _state.error(indicator: indicator, text: text, duration: duration);
  }

  done() {
    _state.done();
  }

  @override
  ProgressHUDState createState() => _state;
}

class ProgressHUDState extends State<ProgressHUD> {
  _HUDIndicator hudInd;

  /// 开始显示
  show({Widget indicator, String text}) {
    setState(() {
      if (mounted) {
        hudInd = _HUDIndicator(indicator: indicator, loadText: text);
      }
    });
  }

  success({Widget indicator, String text, int duration = 600}) {
    _dismiss(duration,
        hudind: _HUDIndicator(
          indicator: indicator ??
              Icon(
                Icons.done,
                color: Colors.greenAccent,
                size: 30,
              ),
          loadText: text ?? '成功',
        ));
  }

  error({Widget indicator, String text, int duration = 600}) {
    _dismiss(duration,
        hudind: _HUDIndicator(
          indicator: indicator ??
              Icon(
                Icons.error,
                color: Colors.redAccent,
                size: 30,
              ),
          loadText: text ?? '错误',
        ));
  }

  done() {
    setState(() {
      if (mounted) {
        hudInd = null;
      }
    });
  }

  _dismiss(int duration, {_HUDIndicator hudind}) {
    setState(() {
      hudInd = hudind;
    });
    Future.delayed(Duration(milliseconds: duration), () {
      done();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: hudInd != null
          ? [
              Opacity(
                opacity: 0.05,
                child: Container(
                  color: Colors.black,
                  height: size.height - kToolbarHeight,
                ),
              ),
              _ProgressBox(hudInd: hudInd)
            ]
          : [],
    );
  }
}
