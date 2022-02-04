import 'package:flutter/material.dart';

import 'package:girls_agent_app/generated/l10n.dart';

class ProfilesPage extends StatelessWidget {
  const ProfilesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).profiles,
        ),
      ),
      body: Center(
        child: Text(
          S.of(context).profiles,
          style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
