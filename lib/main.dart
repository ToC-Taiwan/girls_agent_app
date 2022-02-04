import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:girls_agent_app/intro.dart';
import 'package:girls_agent_app/generated/l10n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(
      testDeviceIds: ['kGADSimulatorID'],
    ),
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
      // theme: ThemeData(
      //   primarySwatch: MaterialColor(0xFFFFF8E1, amberColorMap),
      //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //     backgroundColor: MaterialColor(0xFFE8EAF6, indigoColorMap),
      //     selectedItemColor: Colors.black,
      //   ),
      // ),
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

var amberColorMap = <int, Color>{
  50: const Color(0xFFFFF8E1),
  100: const Color(0xFFFFECB3),
  200: const Color(0xFFFFE082),
  300: const Color(0xFFFFD54F),
  400: const Color(0xFFFFCA28),
  500: const Color(0xFFFFC107),
  600: const Color(0xFFFFB300),
  700: const Color(0xFFFFA000),
  800: const Color(0xFFFF8F00),
  900: const Color(0xFFFF6F00),
};

var indigoColorMap = <int, Color>{
  50: const Color(0xFFE8EAF6),
  100: const Color(0xFFC5CAE9),
  200: const Color(0xFF9FA8DA),
  300: const Color(0xFF7986CB),
  400: const Color(0xFF5C6BC0),
  500: const Color(0xFF3F51B5),
  600: const Color(0xFF3949AB),
  700: const Color(0xFF303F9F),
  800: const Color(0xFF283593),
  900: const Color(0xFF1A237E),
};
