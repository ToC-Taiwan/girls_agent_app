import 'package:flutter/material.dart';
import 'package:girls_agent_app/database.dart';
import 'package:girls_agent_app/generated/l10n.dart';
import 'package:girls_agent_app/layout/app_bar.dart';
import 'package:girls_agent_app/layout/calendar.dart';
import 'package:girls_agent_app/layout/dashboard.dart';
import 'package:girls_agent_app/layout/drawer.dart';
import 'package:girls_agent_app/layout/report.dart';
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
      drawer: drawer(context),
      appBar: appBar(context, widget.title),
      body: pages[_currentIndex] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(235, 153, 208, 218),
        unselectedItemColor: Colors.pink.shade50,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        fixedColor: Colors.pink,
        // elevation: 10,
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
        ],
        currentIndex: _currentIndex,
        onTap: _onItemClick,
      ),
    );
  }
}
