import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:girls_agent_app/firebase_options.dart';
import 'package:girls_agent_app/generated/l10n.dart';
import 'package:girls_agent_app/intro.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await MobileAds.instance.initialize();
  await MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(
      testDeviceIds: ['kGADSimulatorID', '97ff2d08e18eb41e5058971a51df8a82'],
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  final database = await openDatabase(
    join(await getDatabasesPath(), 'girls_agent_app.db'),
  );

  await database.execute('CREATE TABLE IF NOT EXISTS timeline(id INTEGER PRIMARY KEY, year TEXT, month TEXT, day TEXT);');

  var messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();

  var token = await FirebaseMessaging.instance.getToken();
  if (kDebugMode) {
    print(token);
  }

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
