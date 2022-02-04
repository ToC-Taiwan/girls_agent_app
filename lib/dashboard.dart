import 'package:flutter/material.dart';

import 'package:girls_agent_app/generated/l10n.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        S.of(context).dashboard,
        style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
      ),
    );
  }
}
