import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:girls_agent_app/database.dart';
import 'package:girls_agent_app/firebase_options.dart';
import 'package:girls_agent_app/generated/l10n.dart';
import 'package:girls_agent_app/intro.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // adsense
  await MobileAds.instance.initialize();
  await MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(
      testDeviceIds: ['kGADSimulatorID', '96cc288e34c9624be4ff75b63b4f0100'],
    ),
  );

  // floor
  final db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  // FCM
  var messaging = FirebaseMessaging.instance;
  if (Platform.isIOS) {
    await messaging.requestPermission();
  }

  // var token = await FirebaseMessaging.instance.getToken();
  // print(token);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(
    GirlsAgentAPP(
      db: db,
    ),
  );
}

class GirlsAgentAPP extends StatelessWidget {
  const GirlsAgentAPP({Key? key, required this.db}) : super(key: key);
  final AppDatabase db;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GirlsAgentAPP',
      home: IntroPage(
        db: db,
      ),
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
