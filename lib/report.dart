import 'package:flutter/material.dart';
import 'package:girls_agent_app/ad_id.dart';
import 'package:girls_agent_app/generated/l10n.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AnalyzePage extends StatefulWidget {
  const AnalyzePage({Key? key}) : super(key: key);

  @override
  _AnalyzePageState createState() => _AnalyzePageState();
}

class _AnalyzePageState extends State<AnalyzePage> {
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

  @override
  void initState() {
    super.initState();
    _loadInterstitialAd();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitID,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              // _moveToHome();
              _loadInterstitialAd();
            },
          );
          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  // static const kIcons = <Icon>[
  //   Icon(Icons.event),
  //   Icon(Icons.home),
  //   Icon(Icons.android),
  //   Icon(Icons.alarm),
  //   Icon(Icons.face),
  //   Icon(Icons.language),
  // ];
  List<Widget> kIcons = [];

  @override
  Widget build(BuildContext context) {
    var i = 0;
    while (i < 20) {
      i++;
      kIcons.add(reportCard());
    }
    return DefaultTabController(
      length: kIcons.length,
      // Use a Builder here, otherwise `DefaultTabController.of(context)` below
      // returns null.
      child: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              // const TabPageSelector(),
              Expanded(
                child: IconTheme(
                  data: IconThemeData(
                    size: 128,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: TabBarView(children: kIcons),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(3),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                      final controller = DefaultTabController.of(context)!;
                      if (!controller.indexIsChanging) {
                        controller.animateTo(0);
                      }
                    },
                    child: const Text(
                      'FIRST',
                      style: TextStyle(color: Colors.pink),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(3),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                      final controller = DefaultTabController.of(context)!;
                      if (!controller.indexIsChanging) {
                        controller.animateTo(kIcons.length - 1);
                      }
                    },
                    child: const Text(
                      'LAST',
                      style: TextStyle(color: Colors.pink),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(3),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                      if (_isInterstitialAdReady) {
                        _interstitialAd?.show();
                      }
                    },
                    child: const Icon(
                      Icons.refresh,
                      color: Colors.pink,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget reportCard() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
    child: Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(12),
      shadowColor: Colors.pink.shade100,
      child: SizedBox(
        height: 250,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                S.current.report,
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              const Text(
                '2022-01-09 ~ 2022-01-17',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
