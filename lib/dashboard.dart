import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:girls_agent_app/generated/l10n.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  static final List<String> chartDropdownItems = ['Last 7 days', 'Last month', 'Last year'];
  String actualDropdown = chartDropdownItems[0];
  int actualChart = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        children: <Widget>[
          _buildTile(
            2,
            1,
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(S.of(context).dashboard, style: const TextStyle(color: Colors.blueAccent)),
                        const Text('265K', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0))
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 80,
                      child: Material(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(24.0),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(Icons.timeline, color: Colors.white, size: 30.0),
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
              padding: const EdgeInsets.all(24.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
                Material(
                    color: Colors.teal,
                    shape: CircleBorder(),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.settings_applications, color: Colors.white, size: 30.0),
                    )),
                Padding(padding: EdgeInsets.only(bottom: 16.0)),
                Text('General', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
                Text('Images, Videos', style: TextStyle(color: Colors.black45)),
              ]),
            ),
          ),
          _buildTile(
            1,
            1,
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: const <Widget>[
                Material(
                    color: Colors.amber,
                    shape: CircleBorder(),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.notifications, color: Colors.white, size: 30.0),
                    )),
                Padding(padding: EdgeInsets.only(bottom: 16.0)),
                Text('Alerts', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
                Text('All ', style: TextStyle(color: Colors.black45)),
              ]),
            ),
          ),
          // _buildTile(
          //   Padding(
          //       padding: const EdgeInsets.all(24.0),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: <Widget>[
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: <Widget>[
          //               Column(
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: const <Widget>[
          //                   Text('Revenue', style: TextStyle(color: Colors.green)),
          //                   Text('\$16K', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
          //                 ],
          //               ),
          //               DropdownButton(
          //                   isDense: true,
          //                   value: actualDropdown,
          //                   onChanged: (String? value) => setState(() {
          //                         actualDropdown = value!;
          //                         actualChart = chartDropdownItems.indexOf(value); // Refresh the chart
          //                       }),
          //                   items: chartDropdownItems.map((String title) {
          //                     return DropdownMenuItem(
          //                       value: title,
          //                       child: Text(title, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w400, fontSize: 14.0)),
          //                     );
          //                   }).toList())
          //             ],
          //           ),
          //           const Padding(padding: EdgeInsets.only(bottom: 4.0)),
          //           // Sparkline(
          //           //   data: charts[actualChart],
          //           //   lineWidth: 5.0,
          //           //   lineColor: Colors.greenAccent,
          //           // )
          //         ],
          //       )),
          // ),
          // _buildTile(
          //     Padding(
          //       padding: const EdgeInsets.all(24.0),
          //       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
          //         Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: const <Widget>[
          //             Text('Shop Items', style: TextStyle(color: Colors.redAccent)),
          //             Text('173', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0))
          //           ],
          //         ),
          //         Material(
          //             color: Colors.red,
          //             borderRadius: BorderRadius.circular(24.0),
          //             child: const Center(
          //                 child: Padding(
          //               padding: EdgeInsets.all(16.0),
          //               child: Icon(Icons.store, color: Colors.white, size: 30.0),
          //             )))
          //       ]),
          //     ),
          //     // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ShopItemsPage())),
          //     onTap: () {})
        ],
        // staggeredTiles: [
        //   StaggeredTile.extent(2, 110.0),
        //   StaggeredTile.extent(1, 180.0),
        //   StaggeredTile.extent(1, 180.0),
        //   StaggeredTile.extent(2, 220.0),
        //   StaggeredTile.extent(2, 110.0),
        // ],
      ),
    );
  }

  Widget _buildTile(int cross, main, Widget child, {Function()? onTap}) {
    return StaggeredGridTile.count(
      crossAxisCellCount: cross,
      mainAxisCellCount: main,
      child: Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: const Color(0x802196F3),
        child: InkWell(
          onTap: onTap != null ? () => onTap() : () {},
          child: child,
        ),
      ),
    );
  }
}
