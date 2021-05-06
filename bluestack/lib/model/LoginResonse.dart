import 'package:shared_preferences/shared_preferences.dart';

class LoginModel {
  String status;
  String message;
  LoginModel();

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    var model = LoginModel();
    model.status = json["status"] as String;
    model.message = json["message"] as String;
    if(model.status == "0") return model;
    model.saveData(json);
    return model;
  }

  saveData(Map<String, dynamic> json) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("status", json["status"] as String);
  }

}