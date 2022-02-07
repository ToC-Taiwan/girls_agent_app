import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:girls_agent_app/intro.dart';
import 'package:girls_agent_app/generated/l10n.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(
      testDeviceIds: ['kGADSimulatorID'],
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  final database = await openDatabase(
    join(await getDatabasesPath(), 'girls_agent_app.db'),
    singleInstance: true,
  );
  database.execute('CREATE TABLE IF NOT EXISTS timeline(id INTEGER PRIMARY KEY, name TEXT, age INTEGER);');
  database.execute('CREATE TABLE IF NOT EXISTS dashboard(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)');

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
