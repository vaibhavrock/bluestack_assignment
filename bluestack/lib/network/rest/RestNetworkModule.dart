import 'dart:convert';

import 'package:bluestack/model/TournamentModel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RestNetworkModule {
  Map<String, String> headers = {};

  Future<TournamentResponse> getTournamentAPI(url, method, param) async {
    var response = await _fetchRestApi(url, method, param);
    return TournamentResponse.parseResponse(response.body, response.statusCode);
  }

  Future<Response> _fetchRestApi(url, method, param) async {
    print("Rest URl:"+url);
    print("Rest Method: "+method);
    if(param != null){
      print("Rest Param: "+param.toString());
    }
    if (method == "get") {
      var response = await http.get(url, headers: headers);
      print("Rest Response: "+response.body);
      return response;
    } else if (method == "post") {
      var response = await http.post(url, body: param, headers: headers);
      print("Rest Response: "+response.body);
      return response;
    }
    return null;
  }

}
