import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:girls_agent_app/basic/ad_id.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final BannerAd myBanner = BannerAd(
    adUnitId: bannerAdUnitID,
    size: AdSize.banner,
    request: const AdRequest(),
    listener: BannerAdListener(
      onAdFailedToLoad: (ad, _) {
        // Dispose the ad here to free resources.
        ad.dispose();
      },
    ),
  );

  @override
  void initState() {
    super.initState();
    myBanner.load();
  }

  @override
  Widget build(BuildContext context) {
    final adWidget = AdWidget(ad: myBanner);
    final adContainer = Container(
      padding: const EdgeInsets.only(top: 5),
      alignment: Alignment.center,
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
      child: adWidget,
    );
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: ListView(
        children: [
          StaggeredGrid.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: <Widget>[
              _buildTile(
                2,
                1,
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text('Period', style: TextStyle(color: Colors.blueAccent)),
                            // BarChart(barChartData),
                            // const Text('265K', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0))
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 80,
                          child: Material(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(24),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Icon(Icons.timeline, color: Colors.white, size: 30),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              _buildTile(
                1,
                1,
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
                    Material(
                        color: Colors.teal,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Icon(Icons.notification_add, color: Colors.white, size: 30),
                        )),
                    Padding(padding: EdgeInsets.only(bottom: 16)),
                    Text('Rest Days', style: TextStyle(color: Colors.black45)),
                    Text('18', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24)),
                  ]),
                ),
              ),
              _buildTile(
                1,
                1,
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
                    Material(
                        color: Colors.amber,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Icon(Icons.favorite, color: Colors.white, size: 30),
                        )),
                    Padding(padding: EdgeInsets.only(bottom: 16)),
                    Text('Last Time', style: TextStyle(color: Colors.black45)),
                    Text('Normal', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24)),
                  ]),
                ),
              ),
              _buildTile(
                  2,
                  1,
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: adContainer,
                  )),
              _buildTile(
                2,
                1,
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text('Stability', style: TextStyle(color: Colors.blueAccent)),
                            Text('97%', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 80,
                          child: Material(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(24),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Icon(Icons.timeline, color: Colors.white, size: 30),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTile(int cross, main, Widget child, {Function()? onTap}) {
    return StaggeredGridTile.count(
      crossAxisCellCount: cross,
      mainAxisCellCount: main,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        shadowColor: Colors.pink.shade50,
        child: InkWell(
          onTap: onTap != null ? () => onTap() : () {},
          child: child,
        ),
      ),
    );
  }
}
