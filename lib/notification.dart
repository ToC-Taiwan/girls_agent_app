import 'package:flutter/material.dart';

import 'package:girls_agent_app/generated/l10n.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<NotificationPage> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const numItems = 20;
    const _biggerFont = TextStyle(fontSize: 18.0);

    Widget _buildRow(int idx) {
      return ListTile(
        leading: CircleAvatar(
          child: Text('$idx'),
        ),
        title: Text(
          S.of(context).notification + ' ' + idx.toString(),
          style: _biggerFont,
        ),
        trailing: const Icon(Icons.dashboard),
      );
    }

    return DefaultTabController(
      length: MediaQuery.of(context).size.width.toInt(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: TabBar(
            controller: tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.indigo,
            tabs: const [
              Tab(text: 'Unread'),
              Tab(text: 'Read'),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            ListView.builder(
              itemCount: numItems * 2,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (BuildContext context, int i) {
                if (i.isOdd) return const Divider();
                final index = i ~/ 2 + 1;
                return _buildRow(index);
              },
            ),
            ListView.builder(
              itemCount: numItems * 2,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (BuildContext context, int i) {
                if (i.isOdd) return const Divider();
                final index = i ~/ 2 + 1;
                return _buildRow(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
