import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final ValueWidgetBuilder<T> builder;
  final T model;
  final Widget child;
  final Function(T model) onModelReady;

  ProviderWidget({
    Key key,
    @required this.builder,
    @required this.model,
    this.child,
    this.onModelReady,
  }) : super(key: key);

  @override
  _ProviderWidgetState<T> createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  T model;

  @override
  void initState() {
    model = widget.model;
    widget.onModelReady?.call(model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
        value: model,
        child: Consumer<T>(
          builder: widget.builder,
          child: widget.child,
        ));
  }
}
