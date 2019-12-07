import 'package:acra/services/location_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:acra/ui/villagescreen.dart';
import 'package:acra/uidata.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:acra/models/user_location.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:acra/app_localization.dart';
import 'package:acra/services/auth_service.dart';

class App extends StatelessWidget {
  final Location location = new Location();

  @override
  Widget build(BuildContext context) {
    AuthService()..signInWithEmailAndPassword();
    // TODO: implement build

    // return StreamProvider<FirebaseUser>(
    //   //* first stream for app Authentification
    //   builder: (context) => AuthService().userStream,
    //   child: StreamProvider<UserLocation>(
    //     //* second stream for Location
    //     builder: (context) => LocationService().locationStream,
    //     child: MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       // theme: ThemeData.dark(),
    //       theme: ThemeData(
    //           primaryColor: UIData.acraorangecolor,
    //           accentColor: Colors.white //Color(0xF26513), //0xFFe60028
    //           ),
    //       supportedLocales: [Locale('en'), Locale('fr')], //, 'EN','FR'
    //       localizationsDelegates: [
    //         //THIS CLASS WILL BE ADDED LATER
    //         //A class which loads the translations from json files
    //         AppLocalizations.delegate,
    //         //built in localization o fbasic text for Material Widgets
    //         GlobalMaterialLocalizations.delegate,
    //         //built in localization r text direction LTR(left to right)/RTL(right to left)
    //         GlobalWidgetsLocalizations.delegate,
    //       ],
    //       // Returns a locale which will be used by the app
    //       localeResolutionCallback: (locale, supportedLocales) {
    //         // Check if the current device locale is supported
    //         for (var supportedLocale in supportedLocales) {
    //           if (supportedLocale.languageCode == locale.languageCode) {
    //             return supportedLocale;
    //           }
    //         }
    //         // If the locale of the device is not supported, use the first one
    //         // from the list (English, in this case).
    //         return supportedLocales.first;
    //       },
    //       home: Scaffold(
    //         body: VillageScreen(),
    //       ),
    //     ),
    //   ),
    // );

    return StreamProvider<UserLocation>(
      builder: (context) => LocationService().locationStream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData.dark(),
        theme: ThemeData(
            primaryColor: UIData.acraorangecolor,
            accentColor: Colors.white //Color(0xF26513), //0xFFe60028
            ),
        supportedLocales: [Locale('en'), Locale('fr')], //, 'EN','FR'
        localizationsDelegates: [
          //THIS CLASS WILL BE ADDED LATER
          //A class which loads the translations from json files
          AppLocalizations.delegate,
          //built in localization o fbasic text for Material Widgets
          GlobalMaterialLocalizations.delegate,
          //built in localization r text direction LTR(left to right)/RTL(right to left)
          GlobalWidgetsLocalizations.delegate,
        ],
        // Returns a locale which will be used by the app
        localeResolutionCallback: (locale, supportedLocales) {
          // Check if the current device locale is supported
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
          // If the locale of the device is not supported, use the first one
          // from the list (English, in this case).
          return supportedLocales.first;
        },
        home: Scaffold(
          body: VillageScreen(),
        ),
      ),
    );
  }
}
