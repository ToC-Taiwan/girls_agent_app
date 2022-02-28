import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:girls_agent_app/database.dart';
import 'package:girls_agent_app/generated/l10n.dart';
import 'package:girls_agent_app/layout/homepage.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key, required this.db}) : super(key: key);
  final AppDatabase db;

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
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() => expanded = true)).then((value) => const Duration(seconds: 1)).then(
          (value) => Future.delayed(const Duration(seconds: 1)).then(
            (value) => _lottieAnimation.forward().then(
                  (value) => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          title: S.of(context).app_title,
                          db: widget.db,
                        ),
                      ),
                      (route) => false),
                ),
          ),
        );
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => initPlugin());
  }

  Future<void> initPlugin() async {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (Platform.isIOS && status == TrackingStatus.notDetermined) {
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
