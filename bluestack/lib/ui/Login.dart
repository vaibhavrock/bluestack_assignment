import 'package:bluestack/bloc/LoginBloc.dart';
import 'package:bluestack/model/LoginResonse.dart';
import 'package:bluestack/provider/MyProvider.dart';
import 'package:bluestack/utils/Generic.dart';
import 'package:flutter/material.dart';

import 'Home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  LoginBloc _bloc ;
  TextStyle _inputTextStyle = TextStyle(
    /*fontFamily: 'Montserrat',*/
    fontSize: 12.0,
    color: Colors.black,
  );
  TextStyle _loginTextStyle = TextStyle(
      /*fontFamily: 'Montserrat', */
      fontSize: 14.0,
      color: Colors.black);
  TextStyle _outerTextStyle = TextStyle(
      /*fontFamily: 'Montserrat', */
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      color: Colors.black);

  InputDecoration usernameInputDecoration(snap, hintText, labelText) {
    return InputDecoration(
        errorText: snap.error, //info: It's use for visible error message in field bottom
        prefixIcon: Icon(
          Icons.supervised_user_circle,
          color: Colors.black,
          size: 24.0,
        ),
        suffixIcon: _usernameController.text.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.close),
                color: Colors.black,
                onPressed: () {
                  _userNameFocus.requestFocus();
                  Future.delayed(Duration(milliseconds: 50), () {
                    _usernameController.clear();
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                  // _passwordController.clear();
                })
            : null,
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          borderSide: const BorderSide(color: Colors.black, width: 0.0),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          borderSide: const BorderSide(color: Colors.black, width: 0.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          borderSide: const BorderSide(color: Colors.black, width: 0.0),
        ),
        labelStyle: TextStyle(color: Colors.black));
  }

  InputDecoration passwordInputDecoration(snap, hintText, labelText) {
    return InputDecoration(
        errorText: snap.error, //info: It's use for visible error message in field bottom
        //errorStyle: ,
        //errorBorder: ,
        prefixIcon: Icon(
          Icons.vpn_key,
          color: Colors.black,
          size: 24.0,
        ),
        suffixIcon: _passwordController.text.isNotEmpty
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  semanticLabel:
                      _obscureText ? 'show password' : 'hide password',
                  color: Colors.black,
                ),
                //color: getThemeColor(),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          borderSide: const BorderSide(color: Colors.black, width: 0.0),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          borderSide: const BorderSide(color: Colors.black, width: 0.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          borderSide: const BorderSide(color: Colors.black, width: 0.0),
        ),
        labelStyle: TextStyle(color: Colors.black));
  }

  bool visibleDialog = false;

  TextEditingController _usernameController;

  TextEditingController _passwordController;

  FocusNode _userNameFocus;

  FocusNode _passwordFocus;

  bool _wasEmptyUserName;

  bool _wasEmptyPassword;

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    _userNameFocus = FocusNode();
    _passwordFocus = FocusNode();

    _wasEmptyUserName = _usernameController.text.isEmpty;
    _wasEmptyPassword = _passwordController.text.isEmpty;

    _usernameController.addListener(() {
      if (_wasEmptyUserName != _usernameController.text.isEmpty) {
        setState(() => {_wasEmptyUserName = _usernameController.text.isEmpty});
      }
    });

    _passwordController.addListener(() {
      if (_wasEmptyPassword != _passwordController.text.isEmpty) {
        setState(() => {_wasEmptyPassword = _passwordController.text.isEmpty});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _bloc = MyProvider.of(context);

    Widget _usernameField() {
      return StreamBuilder(
        stream: _bloc.userNameStream,
        builder: (context, snap) {
          return SizedBox(
              child: TextFormField(
            onChanged: _bloc.changeUserName,
            controller: _usernameController,
            textInputAction: TextInputAction.next,
            focusNode: _userNameFocus,
            onFieldSubmitted: (term) {
              fieldFocusChange(context, _userNameFocus, _passwordFocus);
            },
            obscureText: false,
            style: _inputTextStyle,
            decoration: usernameInputDecoration(snap, "Username", "Username"),
          ));
        },
      );
    }

    Widget _passwordField() {
      return StreamBuilder(
          stream: _bloc.passwordStream,
          builder: (context, snap) {
            return TextFormField(
                textInputAction: TextInputAction.next,
                onChanged: _bloc.changePassword,
                controller: _passwordController,
                obscureText: _obscureText,
                focusNode: _passwordFocus,
                onFieldSubmitted: (value) {
                  _passwordFocus.unfocus();
                },
                style: _inputTextStyle,
                decoration:
                    passwordInputDecoration(snap, "Password", "Password"));
          });
    }

    Widget _loginButton() {
      return StreamBuilder<bool>(
          stream: _bloc.submitValid,
          builder: (context, snap) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    "Login",
                    style: _loginTextStyle,
                  ),
                ),
                Container(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: snap.hasError? Colors.grey: Colors.black,
                      child: MaterialButton(
                        minWidth: 100,
                        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        onPressed: () async {
                          // TODO: hide progress bar
                          FocusScope.of(context).unfocus();
                          await showCircleProgressDialog(context);
                          _bloc.loginFetcher.listen(_onCallBack);

                          if (!snap.hasData) {
                            if (visibleDialog) {
                              setState(() {
                                this.visibleDialog = false;
                              });
                              // hide dialog
                              Navigator.pop(context);
                            }
                            Generic().failedShank(context, "Please enter valid credential.");
                            return;
                          }
                          snap = null;
                          _bloc.submit();
                        },
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/ic_logo.png',
            width: 120,
          ),
          SizedBox(
            height: 30,
          ),
          _usernameField(),
          SizedBox(
            height: 15,
          ),
          _passwordField(),
          SizedBox(
            height: 20,
          ),
          _loginButton()
        ],
      )),
    );
  }

  Future<bool> action() async {
    //replace the below line of code with your login request
    await new Future.delayed(const Duration(seconds: 2));
    return true;
  }

  Future showCircleProgressDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: new Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: new CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ));
        });
    await action();

    visibleDialog = true;
  }

  fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _onCallBack(LoginModel response) {
    if (_bloc.responseCome) {
      _bloc.responseCome = false;

      if (visibleDialog) {
        setState(() {
          this.visibleDialog = false;
        });
        // hide dialog
        Navigator.pop(context);
      }

      if (response.status == "0") {
        Generic().failedShank(context, response.message);
        return;
      }
      Generic().successShank(context, response.message);
      _navigationPage();
    }
  }

  void _navigationPage() {
    Generic().screenPushAndRemoveUntil(context, Home());
  }
}
