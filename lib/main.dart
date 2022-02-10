import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:girls_agent_app/intro.dart';
import 'package:girls_agent_app/generated/l10n.dart';
import 'package:girls_agent_app/firebase_options.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(
      testDeviceIds: ['kGADSimulatorID', '97ff2d08e18eb41e5058971a51df8a82'],
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  final database = await openDatabase(
    join(await getDatabasesPath(), 'girls_agent_app.db'),
    singleInstance: true,
  );

  database.execute('CREATE TABLE IF NOT EXISTS timeline(id INTEGER PRIMARY KEY, name TEXT, age INTEGER);');

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  // print('User granted permission: ${settings.authorizationStatus}');
  // var token = await FirebaseMessaging.instance.getToken();
  // print(token);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );

  runApp(
    const GirlsAgentAPP(),
  );
}

class GirlsAgentAPP extends StatelessWidget {
  const GirlsAgentAPP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GirlsAgentAPP',
      home: const IntroPage(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
