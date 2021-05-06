import 'package:bluestack/model/TournamentModel.dart';
import 'package:bluestack/repository/Repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc{
  var _repository = Repository();
  var _tournament = BehaviorSubject<TournamentResponse>();

  BehaviorSubject<TournamentResponse> get fetcher => _tournament;

  fetchTournament() async {
    var model = await _repository.getTournament();
    _tournament.sink.add(model);
  }


  void dispose() async {
    await _tournament.drain();
    _tournament.close();
  }
}
