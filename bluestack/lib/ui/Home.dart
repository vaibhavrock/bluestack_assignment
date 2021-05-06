import 'package:bluestack/bloc/HomeBloc.dart';
import 'package:bluestack/model/TournamentModel.dart';
import 'package:bluestack/provider/MyProvider.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //List<bool> isSelected;
  HomeBloc _bloc;

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = MyProvider.homebloc(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Flyingwolf", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Container(
          padding: EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/images/ic_humburger.png',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 30),
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 80,
                        width: 80,
                        child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/ic_logo.png"),
                            backgroundColor: Colors.grey.shade300)),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Simon Baker",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    12.0) //                 <--- border radius here
                                ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "2250",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Elo rating",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.blueAccent),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return ToggleButtons(
                      renderBorder: false,
                      constraints: BoxConstraints.expand(
                          width: constraints.maxWidth / 3),
                      borderRadius: BorderRadius.circular(10),
                      children: [
                        Container(
                          //color: Colors.orange,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.orange, Colors.deepOrange])),
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            '34\nTournaments\nplayed',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                        Container(
                          //color: Colors.purple,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.purple, Colors.deepPurple])),
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Center(
                              child: Text(
                            '09\nTournaments\nwon',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                        Container(
                          //color: Colors.redAccent,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.redAccent, Colors.red])),
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Center(
                              child: Text(
                            '26%\nWinning\npercentage',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ],
                      isSelected: [true, true, true],
                      onPressed: (index) {},
                    );
                  })),
              SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Text("Recommended for you",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: tournamentList())
            ],
          ),
        ),
      ),
    );
  }

  Widget tournamentList() {
    _bloc.fetchTournament();
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
        }
        return snapshot.hasData
            ? TournamentList(tourList: snapshot.data as TournamentResponse)
            : Center(child: CircularProgressIndicator());
      },
      stream: _bloc.fetcher,
    );
  }

  Widget TournamentList({TournamentResponse tourList}) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return _tourList(context, tourList.list[index]);
        },
        itemCount: tourList.list.length,
      ),
    );
  }

  Widget _tourList(BuildContext context, TournamentModel list) {
    return Card(
      //semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.grey.shade200,
      //margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        //padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInImage(
              height: 100,
              width: double.infinity,
              placeholder: new AssetImage('assets/images/ic_logo.png'),
              image: NetworkImage(list.cover_url),
              fit: BoxFit.fill,
              alignment: Alignment.center,
              fadeInDuration: new Duration(milliseconds: 200),
              fadeInCurve: Curves.linear,
            ),
            Container(
              height: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 8.0, left: 2.0, right: 8.0),
                      child: FittedBox(
                          child: Text(
                        list.name,
                        style: TextStyle(fontSize: 14),
                      ))),
                  Container(
                      padding: EdgeInsets.only(top: 8.0, left: 2.0, right: 8.0),
                      child: Text(
                        list.game_name,
                        style: TextStyle(fontSize: 11),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
