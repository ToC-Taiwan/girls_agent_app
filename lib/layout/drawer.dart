import 'package:flutter/material.dart';
import 'package:girls_agent_app/generated/l10n.dart';
import 'package:girls_agent_app/layout/profiles.dart';
import 'package:girls_agent_app/layout/settings.dart';

Widget drawer(BuildContext context) {
  return Container(
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
  );
}
