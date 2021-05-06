import 'dart:async';

import 'package:bluestack/model/TournamentModel.dart';
import 'package:bluestack/network/rest/RestNetworkModule.dart';

class Repository {

  static final Repository _singleton = Repository._internal();

  factory Repository() {
    return _singleton;
  }

  Repository._internal();
  final _restApiProvider = RestNetworkModule();

  Future<TournamentResponse> getTournament() {
  /*  var param = new Map<String, dynamic>();
    param["userName"] = "";
    param["password"] = "";*/

    var url = "http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all";
    return _restApiProvider.getTournamentAPI(url, "get", null);
  }


}
