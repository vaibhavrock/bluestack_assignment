import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Created by Vaibhav Upadhyay
class Generic {
  static final Generic _instance = Generic._internal();

  Generic._internal();

  factory Generic() => _instance;

  //info: this is use for navigate screen without argument
  screenPush(context, widget) {
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (_) => widget,
    ));
  }

  //info: this is use for navigate screen with argument or without argument
  screenPushNamed(context, routeName, {argument}) {
    Navigator.of(context).pushNamed(routeName, arguments: argument);
  }

  //info: this is use for remove screen with current path and create new path
  screenPushAndRemoveUntil(context, widget) {
    var newRoute = MaterialPageRoute(
      builder: (BuildContext context) => widget,
    );
    Navigator.pushAndRemoveUntil(context, newRoute, (route) => false);
  }

  //info: this is use for remove screen with current path and create new path with pushNamed
  screenPushNamedAndRemoveUntil(context, routeName, {argument}) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }

  //info: this is use for replace old screen
  screenPushReplacement(context, widget) {
    var newRoute = MaterialPageRoute(
      builder: (BuildContext context) => widget,
    );
    Navigator.pushReplacement(context, newRoute);
  }

  //info: this is use for replace old screen with named route
  screenPushReplacementNamed(context, routeName, {argument}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: argument);
  }

  //info: this is use for remove screen or go back from screen
  screenPop(context) {
    Navigator.of(context).pop();
  }

  //info: this is use for remove screen or go back from screen with push new route screen
  screenPopAndPushNamed(context, routeName) {
    Navigator.of(context).popAndPushNamed(routeName);
  }

  //info: this is use for remove screen till that root path
  screenPopUntil(context, routeName) {
    var predicate = ModalRoute.withName(routeName);
    Navigator.of(context).popUntil(predicate);
    //or Navigator.of(context).popUntil((route) => false);
  }

  fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  // Snackbar
  showShack(BuildContext context, String msg) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      title: "",
      message: msg,
      duration: Duration(seconds: 2),
    )..show(context);
  }

  successShank(BuildContext context, String msg) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      title: "",
      message: msg,
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    )..show(context);
  }

  failedShank(BuildContext context, String msg) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      title: "",
      message: msg,
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    )..show(context);
  }

  showNetworkError(BuildContext context, String error) {
    //String msg = error;
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      title: "",
      backgroundColor: Colors.red,
      message: error,
      duration: Duration(seconds: 2),
    )..show(context);
  }

  // Snackbar

  String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (value.isNotEmpty) {
      if (!regex.hasMatch(value))
        return 'Enter a valid email address';
      else
        return null;
    }
    return null;
  }

}
