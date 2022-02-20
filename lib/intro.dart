import 'dart:io' show Platform;

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:girls_agent_app/generated/l10n.dart';
import 'package:girls_agent_app/homepage.dart';

// import 'package:firebase_messaging/firebase_messaging.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  late AnimationController _lottieAnimation;

  bool expanded = false;
  final double _bigFontSize = kIsWeb ? 234 : 178;
  final transitionDuration = const Duration(seconds: 1);

  @override
  void initState() {
    _lottieAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    // setupInteractedMessage();

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() => expanded = true)).then((value) => const Duration(seconds: 1)).then(
          (value) => Future.delayed(const Duration(seconds: 1)).then(
            (value) => _lottieAnimation.forward().then(
                  (value) => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          title: S.of(context).app_title,
                        ),
                      ),
                      (route) => false),
                ),
          ),
        );
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => initPlugin());
  }

  // Future<void> setupInteractedMessage() async {
  //   // Get any messages which caused the application to open from
  //   // a terminated state.
  //   RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  //   // If the message also contains a data property with a "type" of "chat",
  //   // navigate to a chat screen
  //   if (initialMessage != null) {
  //     _handleMessage(initialMessage);
  //   }

  //   // Also handle any interaction when the app is in the background via a
  //   // Stream listener
  //   FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  // }

  // void _handleMessage(RemoteMessage message) {
  //   // if (message.data['type'] == 'chat') {
  //   // Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
  //   // Navigator.of(context).pushAndRemoveUntil(
  //   //     MaterialPageRoute(
  //   //       builder: (context) => HomePage(
  //   //         title: S.of(context).app_title,
  //   //       ),
  //   //     ),
  //   //     (route) => false);
  //   // }
  // }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    // If the system can show an authorization request dialog
    if (Platform.isIOS && status == TrackingStatus.notDetermined) {
      // Request system's tracking authorization dialog
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: const Color.fromARGB(252, 153, 208, 218),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedDefaultTextStyle(
              duration: transitionDuration,
              curve: Curves.fastOutSlowIn,
              style: TextStyle(
                color: Colors.black,
                fontSize: !expanded ? _bigFontSize : 50,
                fontWeight: FontWeight.w600,
              ),
              child: const Text(
                'Pd',
              ),
            ),
            AnimatedCrossFade(
              firstCurve: Curves.fastOutSlowIn,
              crossFadeState: !expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: transitionDuration,
              firstChild: Container(),
              secondChild: _logoRemainder(),
              alignment: Alignment.centerLeft,
              sizeCurve: Curves.easeInOut,
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoRemainder() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text(
          'Captain',
          style: TextStyle(
            color: Colors.pink,
            fontSize: 50,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
