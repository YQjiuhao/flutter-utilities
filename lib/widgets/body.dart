// Function
import 'package:flutter/cupertino.dart';

/// 公司：遵义极客信息科技有限责任公司
/// 作者：Biao~~
/// 时间：2019-09-09
///
import 'package:flutter/material.dart';
import 'progress_hud.dart';
import '../common/common.dart';
import '../ux/ux.dart';

class Body<T> extends StatefulWidget {
  Body({
    @required this.builder,
    this.onInit,
    this.message,
    this.useHUD = true,
    this.initData,
    this.autoKeep = false,
  });

  /// 需要初始化，调用这个函数
  final Future<T> onInit;

  final String message;

  /// 子组件/配件
  final AsyncWidgetBuilder<T> builder;

  final T initData;

  /// 是否使用提示动画,，
  ///
  /// 不使用提示动画,就不会将当前Body的context压入栈中，
  ///
  /// 避免使用顺序问题而报错
  final bool useHUD;

  final bool autoKeep;

  @override
  BodyState<T> createState() => BodyState<T>();
}

class BodyState<T> extends State<Body<T>> with AutomaticKeepAliveClientMixin {
  /// 提示动画
  final ProgressHUD hud = ProgressHUD();

  bool _init = false;

  @override
  void initState() {
    if (widget.useHUD == true) {
      UX.share().huds.add(hud);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // UX.context = context;
    if (widget.useHUD == true && !UX.share().contexts.contains(context)) {
      UX.share().contexts.add(context);
    }

    return Stack(
      children: <Widget>[
        FutureBuilder<T>(
          initialData: widget.initData,
          future: widget.onInit,
          builder: (ctx, snaphot) {
            if (isNotNull(widget.onInit) && !_init && isNull(snaphot.data)) {
              _init = true;
              return _LoadingView();
            }
            if (isNotNull(widget.onInit) && isNull(snaphot.data)) {
              return isNull(snaphot.data)
                  ? _EmptyView(initiled: _init, message: widget.message)
                  : widget.builder(ctx, snaphot);
            }
            return widget.builder(ctx, snaphot);
          },
        ),
        hud,
      ],
    );
  }

  @override
  void dispose() {
    if (widget.useHUD == true) {
      UX.removeToast();
      if (!isNull(UX.share().contexts)) {
        UX.share().contexts.remove(context);
      }
      if (!isNull(UX.share().huds)) UX.share().huds.remove(hud);
    }
    super.dispose();
  }

  @override
  bool get wantKeepAlive => widget.autoKeep;
}

class _LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(),
    );
  }
}

class _EmptyView extends StatelessWidget {
  _EmptyView({this.message, this.initiled});

  /// 是否已经初始化
  final bool initiled;

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(32),
            child: Text(
              initiled ? (message ?? '两手空空~~~') : '',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
