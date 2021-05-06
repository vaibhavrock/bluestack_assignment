import 'package:bluestack/provider/MyProvider.dart';
import 'package:bluestack/ui/Home.dart';
import 'package:bluestack/ui/Login.dart';
import 'package:bluestack/ui/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localization/app_localizations_delegate.dart';
import 'localization/application.dart';

class Routes {
  Routes() {
    runApp(MyProvider(
        child: new MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light, fontFamily: "Quicksand"),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: "Quicksand",
      ),
      title: "BlueStack",
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        const AppTranslationsDelegate(),
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: application.supportedLocales(),
      home: SplashScreen(),
      //routes: { '/': (context) => SplashScreen(), },
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/login':
            return new MyCustomRoute(
                builder: (_) => new Login(), settings: settings);
          case '/homescreen':
            return new MyCustomRoute(
                builder: (_) => new Home(), settings: settings);
          default:
            return new MyCustomRoute(
                builder: (_) => new SplashScreen(), settings: settings);
        }
      },
    )));
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.name == "/") return child;
    return new FadeTransition(opacity: animation, child: child);
  }
}
