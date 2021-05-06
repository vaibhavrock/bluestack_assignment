import 'dart:async';

import 'package:bluestack/localization/application.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 2), onDoneLoading);
  }

  onDoneLoading() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getString("status");
    print(status);

    // change saved language
    var language = prefs.getString('language');
    if (language != null) application.onLocaleChanged(Locale(language));

    if (status == '1') {
      Navigator.pushReplacementNamed(context, "/homescreen");
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.grey,
      body: InkWell(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/ic_logo.png',
                            height:
                            (mediaQuery.size.height - mediaQuery.padding.top) *
                                0.3,
                            width:
                            (mediaQuery.size.width - mediaQuery.padding.top) *
                                0.3,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
