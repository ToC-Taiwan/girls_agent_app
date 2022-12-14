import 'package:flutter/material.dart';
import 'package:girls_agent_app/database.dart';
import 'package:girls_agent_app/generated/l10n.dart';
import 'package:girls_agent_app/layout/calendar.dart';
import 'package:girls_agent_app/layout/dashboard.dart';
import 'package:girls_agent_app/layout/profiles.dart';
import 'package:girls_agent_app/layout/report.dart';
import 'package:girls_agent_app/layout/settings.dart';
import 'package:girls_agent_app/layout/timeline.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title, required this.db}) : super(key: key);
  final AppDatabase db;
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List pages = [];

  @override
  void initState() {
    super.initState();
    pages = [
      const DashboardPage(),
      TimeLinePage(
        db: widget.db,
      ),
      const CalendarPage(),
      const AnalyzePage(),
      // const NotificationPage(),
    ];
  }

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
                      image: AssetImage(
                        'assets/app_icon_no_background.png',
                      ),
                    ),
                    color: Colors.indigo,
                  ),
                  child: Column(
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
                leading: const Icon(Icons.perm_contact_calendar_outlined),
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
        iconTheme: const IconThemeData(
          color: Colors.pink,
        ),
        title: Text(widget.title),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.add),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Bleeding',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Bleeding',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Bleeding',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Bleeding',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ];
            },
          )
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(235, 153, 208, 218),
        unselectedItemColor: Colors.pink.shade50,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        fixedColor: Colors.pink,
        // elevation: 10,
        // showUnselectedLabels: true,
        // iconSize: 30,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard),
            label: S.of(context).dashboard,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.timeline),
            label: S.of(context).time_line,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_today_outlined),
            label: S.of(context).calendar,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.receipt_rounded),
            label: S.of(context).report,
          ),
          // BottomNavigationBarItem(
          //   icon: const Icon(Icons.notifications_active_rounded),
          //   label: S.of(context).notification,
          // ),
        ],
        currentIndex: _currentIndex,
        // fixedColor: Colors.blue,
        onTap: _onItemClick,
      ),
    );
  }
}
