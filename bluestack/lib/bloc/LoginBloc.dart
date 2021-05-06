
import 'package:bluestack/model/LoginResonse.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Validator.dart';

class LoginBloc with Validator {
  bool responseCome;
  final _userName = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  final BehaviorSubject<LoginModel> _loginFetcher = BehaviorSubject<LoginModel>();

  Stream<String> get userNameStream => _userName.stream.transform(validateUserName);

  Stream<String> get passwordStream => _password.stream.transform(validatePassword);

  Function(String) get changeUserName => _userName.sink.add;

  Function(String) get changePassword => _password.sink.add;

  BehaviorSubject<LoginModel> get loginFetcher => _loginFetcher;

  Stream<bool> get submitValid => Observable.combineLatest2(userNameStream, passwordStream, (a, b) => true);

  getLoginAuthBloc(String userName, String password) async {
    responseCome = false;
    // User 1: 9898989898 / password
    // User 2: 9876543210 / password
    LoginModel mData  = LoginModel();
    mData.status = "0";
    mData.message = "Invalid User";

    if(userName == "9898989898" || userName == "9876543210"){
      if(password == "password"){
        mData.status = "1";
        mData.message = "User Successfully Registered!";
      }
    }
    if (mData.status == "1") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("username", userName);
      prefs.setString("password", password);
      prefs.setString("status", mData.status);
    }
    responseCome = true;
    _loginFetcher.sink.add(mData);
  }

  dispose() {
    _userName.close();
    _password.close();
    _loginFetcher.close();
  }

  submit() async {
    getLoginAuthBloc(_userName.value, _password.value);
  }

}

