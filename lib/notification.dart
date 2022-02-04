import 'package:flutter/material.dart';

import 'package:girls_agent_app/generated/l10n.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        S.of(context).notification,
        style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
      ),
    );
  }
}
