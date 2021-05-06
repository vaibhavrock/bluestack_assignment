import 'dart:convert';


class TournamentResponse {
  int statusCode;
  TournamentModel model;
  List<TournamentModel> list = [];

  TournamentResponse.parseResponse(var _response, int _statusCode) {

    Map _valueMap = json.decode(_response);
    this.statusCode = _statusCode;
    if(isSuccess()) {
      // Map _valueMap = json.decode(_response);
      List<dynamic> jList = (_valueMap["data"]["tournaments"] as List);
      if (jList != null) {
        for (Map<String, dynamic> map in jList) {
          list.add(TournamentModel.fromJson(map));
        }
      }
    }
  }
  bool isSuccess() => (statusCode == 200);
}

class TournamentModel {
  String name;
  String cover_url;
  String game_name;

  TournamentModel();

  factory TournamentModel.fromJson(Map<String, dynamic> json) {

    var model = TournamentModel();
    model.name = json["name"].toString();
    model.cover_url= json["cover_url"].toString();
    model.game_name= json["game_name"].toString();

    return model;
  }
}

