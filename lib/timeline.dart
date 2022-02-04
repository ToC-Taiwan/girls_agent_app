import 'package:flutter/material.dart';

import 'package:girls_agent_app/generated/l10n.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({Key? key}) : super(key: key);

  @override
  _GearPageState createState() => _GearPageState();
}

class _GearPageState extends State<TimeLinePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        S.of(context).time_line,
        style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
      ),
    );
  }
}
