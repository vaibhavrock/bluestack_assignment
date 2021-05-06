import 'package:bluestack/provider/MyProvider.dart';
import 'package:bluestack/ui/Home.dart';
import 'package:bluestack/ui/Login.dart';
import 'package:bluestack/ui/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localization/app_localizations_delegate.dart';
import 'localization/application.dart';


class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyProvider(
        child: MaterialApp(
            theme: ThemeData(
              brightness: Brightness.light,
              fontFamily: "Quicksand",
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              fontFamily: "Quicksand",
            ),
            title: "BlueStack",
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              _newLocaleDelegate,
              // local delegate
              const AppTranslationsDelegate(),
              //provides localised strings
              GlobalMaterialLocalizations.delegate,
              //provides RTL support
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: application.supportedLocales(),
            localeResolutionCallback: (locale, supportedLocales) {
              // Check if the current device locale is supported
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode ||
                    supportedLocale.countryCode == locale?.countryCode) {
                  return supportedLocale;
                }
              }
              // If the locale of the device is not supported, use the first one
              // from the list (English, in this case).
              return supportedLocales.first;
            },
            initialRoute: '/',
            routes: {
              '/': (context) => SplashScreen(),
              '/login': (context) => Login(),
              '/homescreen': (context) => Home(),
            }
            )
        );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]
  )
      .then((_) {
    runApp(new MyApp());
  });
}
//void main() => runApp(MyApp());
