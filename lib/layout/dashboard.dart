import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:girls_agent_app/basic/ad_id.dart';
import 'package:girls_agent_app/generated/l10n.dart';
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
      padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
      child: ListView(
        shrinkWrap: true,
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
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(S.of(context).period_history, style: const TextStyle(color: Colors.black45, fontSize: 20)),
                            Padding(
                              padding: const EdgeInsets.only(right: 20, top: 10),
                              child: periodChart(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: Material(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(14),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(6),
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
                  2,
                  1,
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: adContainer,
                  )),
              _buildTile(
                1,
                1,
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                    const Material(
                        color: Colors.teal,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Icon(Icons.notification_add, color: Colors.white, size: 30),
                        )),
                    const Padding(padding: EdgeInsets.only(bottom: 16)),
                    Text(S.of(context).next_period, style: const TextStyle(color: Colors.black45)),
                    const Text('18 Days', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24)),
                  ]),
                ),
              ),
              _buildTile(
                1,
                1,
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                    const Material(
                        color: Colors.red,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Icon(Icons.favorite, color: Colors.white, size: 30),
                        )),
                    const Padding(padding: EdgeInsets.only(bottom: 16)),
                    Text(S.of(context).last_period, style: const TextStyle(color: Colors.black45)),
                    Text(S.of(context).on_time, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24)),
                  ]),
                ),
              ),
              _buildTile(
                2,
                1,
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(S.of(context).stability, style: const TextStyle(color: Colors.black45, fontSize: 20)),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text('97%', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 44)),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 80,
                          child: Material(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(14),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(6),
                                child: Icon(Icons.accessibility_new_sharp, color: Colors.white, size: 30),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTile(int cross, main, Widget child, {Function()? onTap}) {
    return StaggeredGridTile.count(
      crossAxisCellCount: cross,
      mainAxisCellCount: main as num,
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

Widget periodChart() {
  return Stack(
    children: <Widget>[
      AspectRatio(
        aspectRatio: 2.7,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
            // color: Color(0xff232d37),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 18, left: 12, top: 24, bottom: 12),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ),
      // SizedBox(
      //   width: 60,
      //   height: 34,
      //   child: TextButton(
      //     onPressed: () {
      //       // setState(() {
      //       //   showAvg = !showAvg;
      //       // });
      //     },
      //     child: Text(
      //       'avg',
      //       style: TextStyle(fontSize: 12, color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
      //     ),
      //   ),
      // ),
    ],
  );
}

LineChartData mainData() {
  var gradientColors = <Color>[
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  return LineChartData(
    gridData: FlGridData(
      show: false,
      drawVerticalLine: true,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      // rightTitles: SideTitles(showTitles: false),
      // topTitles: SideTitles(showTitles: false),
      // bottomTitles: SideTitles(
      //   showTitles: false,
      //   reservedSize: 22,
      //   interval: 1,
      //   getTextStyles: (context, value) => const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
      //   getTitles: (value) {
      //     switch (value.toInt()) {
      //       case 2:
      //         return 'MAR';
      //       case 5:
      //         return 'JUN';
      //       case 8:
      //         return 'SEP';
      //     }
      //     return '';
      //   },
      //   margin: 8,
      // ),
      // leftTitles: SideTitles(
      //   showTitles: true,
      //   interval: 1,
      //   getTextStyles: (context, value) => const TextStyle(
      //     color: Color(0xff67727d),
      //     fontWeight: FontWeight.bold,
      //     fontSize: 15,
      //   ),
      //   getTitles: (value) {
      //     switch (value.toInt()) {
      //       case 1:
      //         return '25';
      //       case 3:
      //         return '28';
      //       case 5:
      //         return '31';
      //     }
      //     return '';
      //   },
      //   reservedSize: 32,
      //   margin: 12,
      // ),
    ),
    borderData: FlBorderData(show: false, border: Border.all(color: const Color(0xff37434d))),
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: 6,
    lineBarsData: [
      LineChartBarData(
        spots: const [
          FlSpot(0, 3),
          FlSpot(2.6, 2),
          FlSpot(4.9, 5),
          FlSpot(6.8, 3.1),
          FlSpot(8, 4),
          FlSpot(9.5, 3),
          FlSpot(11, 4),
        ],
        isCurved: false,
        // colors: gradientColors,
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          // colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
        ),
      ),
    ],
  );
}

LineChartData avgData() {
  var gradientColors = <Color>[
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  return LineChartData(
    lineTouchData: LineTouchData(enabled: false),
    gridData: FlGridData(
      show: true,
      drawHorizontalLine: true,
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      // bottomTitles: SideTitles(
      //   showTitles: true,
      //   reservedSize: 22,
      //   getTextStyles: (context, value) => const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
      //   getTitles: (value) {
      //     switch (value.toInt()) {
      //       case 2:
      //         return 'MAR';
      //       case 5:
      //         return 'JUN';
      //       case 8:
      //         return 'SEP';
      //     }
      //     return '';
      //   },
      //   margin: 8,
      //   interval: 1,
      // ),
      // leftTitles: SideTitles(
      //   showTitles: true,
      //   getTextStyles: (context, value) => const TextStyle(
      //     color: Color(0xff67727d),
      //     fontWeight: FontWeight.bold,
      //     fontSize: 15,
      //   ),
      //   getTitles: (value) {
      //     switch (value.toInt()) {
      //       case 1:
      //         return '10k';
      //       case 3:
      //         return '30k';
      //       case 5:
      //         return '50k';
      //     }
      //     return '';
      //   },
      //   reservedSize: 32,
      //   interval: 1,
      //   margin: 12,
      // ),
      // topTitles: SideTitles(showTitles: false),
      // rightTitles: SideTitles(showTitles: false),
    ),
    borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d))),
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: 6,
    lineBarsData: [
      LineChartBarData(
        spots: const [
          FlSpot(0, 3.44),
          FlSpot(2.6, 3.44),
          FlSpot(4.9, 3.44),
          FlSpot(6.8, 3.44),
          FlSpot(8, 3.44),
          FlSpot(9.5, 3.44),
          FlSpot(11, 3.44),
        ],
        isCurved: true,
        // colors: [
        //   ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!,
        //   ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!,
        // ],
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        // belowBarData: BarAreaData(show: true, colors: [
        //   ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!.withOpacity(0.1),
        //   ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!.withOpacity(0.1),
        // ]),
      ),
    ],
  );
}
