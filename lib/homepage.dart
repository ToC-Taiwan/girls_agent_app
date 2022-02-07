import 'package:flutter/material.dart';

import 'package:girls_agent_app/calendar.dart';
import 'package:girls_agent_app/report.dart';
import 'package:girls_agent_app/dashboard.dart';
import 'package:girls_agent_app/timeline.dart';
import 'package:girls_agent_app/notification.dart';
import 'package:girls_agent_app/settings.dart';
import 'package:girls_agent_app/profiles.dart';
import 'package:girls_agent_app/generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 2;
  final pages = [
    const DashboardPage(),
    const TimeLinePage(),
    const CalendarPage(),
    const AnalyzePage(),
    const NotificationPage(),
  ];

  void _onItemClick(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      drawer: Container(
        color: Colors.indigo,
        padding: const EdgeInsets.only(top: 40),
        width: 200,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 120,
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment.center,
                      image: AssetImage(
                        'assets/app_icon_no_background.png',
                      ),
                    ),
                    color: Colors.indigo,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      // Text(
                      //   S.of(context).pd_center,
                      //   style: const TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: Text(
                  S.of(context).profiles,
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilesPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.three_p),
                title: Text(
                  S.of(context).remove_ad,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.phone),
                title: Text(
                  S.of(context).contact_us,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: Text(
                  S.of(context).settings,
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
            ),
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AlertDialog(
                    actionsAlignment: MainAxisAlignment.center,
                    title: Text(
                      S.of(context).new_event,
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text(
                          'OK',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.indigo.shade300,
        fixedColor: Colors.white,
        elevation: 0,
        // showUnselectedLabels: true,
        iconSize: 25,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard),
            label: S.of(context).dashboard,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.hdr_strong_rounded),
            label: S.of(context).time_line,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_today_rounded),
            label: S.of(context).calendar,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.receipt_rounded),
            label: S.of(context).report,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications_active_rounded),
            label: S.of(context).notification,
          ),
        ],
        currentIndex: _currentIndex,
        // fixedColor: Colors.blue,
        onTap: _onItemClick,
      ),
    );
  }
}
