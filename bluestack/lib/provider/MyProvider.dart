import 'package:bluestack/bloc/HomeBloc.dart';
import 'package:bluestack/bloc/LoginBloc.dart';
import 'package:flutter/material.dart';

class MyProvider extends InheritedWidget {
  final loginBloc = LoginBloc();
  final homeBloc = HomeBloc();

  MyProvider({Key key, Widget child}) : super(key: key, child: child);

  static LoginBloc of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<MyProvider>();
    return widget.loginBloc;
  }

  static HomeBloc homebloc(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<MyProvider>();
    return widget.homeBloc;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}
