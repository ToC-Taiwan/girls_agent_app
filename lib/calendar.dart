import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:girls_agent_app/utils.dart';
import 'package:girls_agent_app/ad_id.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final BannerAd myBanner = BannerAd(
    adUnitId: bannerAdUnitID,
    size: AdSize.banner,
    request: const AdRequest(),
    listener: BannerAdListener(
      onAdFailedToLoad: (Ad ad, LoadAdError _) {
        // Dispose the ad here to free resources.
        ad.dispose();
      },
    ),
  );

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  static const kIcons = <Widget>[
    Icon(Icons.event, color: Colors.pink),
    Icon(Icons.home, color: Colors.pink),
    Icon(Icons.android, color: Colors.pink),
    Icon(Icons.alarm, color: Colors.pink),
    Icon(Icons.face, color: Colors.pink),
    Icon(Icons.language, color: Colors.pink),
  ];

  @override
  void initState() {
    super.initState();
    myBanner.load();
  }

  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(ad: myBanner);
    final Container adContainer = Container(
      padding: const EdgeInsets.only(top: 5),
      alignment: Alignment.center,
      child: adWidget,
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
    );
    return Column(
      // direction: Axis.vertical,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: adContainer,
        ),
        // const Expanded(
        //   flex: 1,
        //   child: SizedBox(
        //     child: Center(
        //       child: Text(
        //         'The 5 Day',
        //         style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        //       ),
        //     ),
        //   ),
        // ),
        Expanded(
          flex: 8,
          child: TableCalendar(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              // Use `selectedDayPredicate` to determine which day is currently selected.
              // If this returns true, then `day` will be marked as selected.

              // Using `isSameDay` is recommended to disregard
              // the time-part of compared DateTime objects.
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
          ),
        ),
        Expanded(
          flex: 5,
          child: DefaultTabController(
            length: kIcons.length,
            // Use a Builder here, otherwise `DefaultTabController.of(context)` below
            // returns null.
            child: Builder(
              builder: (BuildContext context) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: IconTheme(
                        data: IconThemeData(
                          size: 64.0,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.pink.shade50,
                            ),
                            child: const TabBarView(
                              children: kIcons,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TabPageSelector(
                      selectedColor: Colors.pink,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
