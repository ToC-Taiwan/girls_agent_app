import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// import 'package:girls_agent_app/generated/l10n.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({Key? key}) : super(key: key);

  @override
  _GearPageState createState() => _GearPageState();
}

class _GearPageState extends State<TimeLinePage> {
  Future<Database> getConnection() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'girls_agent_app.db'),
    );
    return database;
  }

  Future<void> insertTLine(TimeLine tline) async {
    final db = await getConnection();
    await db.insert(
      'timeline',
      tline.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TimeLine>> allTLines() async {
    final db = await getConnection();
    final List<Map<String, dynamic>> maps = await db.query('timeline', orderBy: 'id desc');
    return List.generate(maps.length, (i) {
      return TimeLine(
        id: maps[i]['id'],
        year: maps[i]['year'],
        month: maps[i]['month'],
        day: maps[i]['day'],
      );
    });
  }

  void doInsert() async {
    int i = 1;
    while (i < 21) {
      i++;
      var fido = TimeLine(
        id: i,
        year: '2022',
        month: 'Feb',
        day: i.toString(),
      );
      await insertTLine(fido);
    }
  }

  late Future<List<TimeLine>> arr;

  @override
  Widget build(BuildContext context) {
    doInsert();
    arr = allTLines();
    return FutureBuilder<List<TimeLine>>(
      future: arr,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<TimeLine> tmp = [];
          tmp = snapshot.data!;
          // return Text(tmp[1].name);
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView(
              shrinkWrap: true,
              children: timeLineGenerator(tmp),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

List<Widget> timeLineGenerator(List<TimeLine> arr) {
  List<Widget> tmp = [];
  for (var element in arr) {
    var card = Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.pink.shade50,
        ),
        height: 80,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.pink.shade50,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        element.year,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 15),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(
                                element.month,
                                style: const TextStyle(fontSize: 15),
                              )),
                          Expanded(
                            flex: 4,
                            child: Text(
                              element.day,
                              style: const TextStyle(fontSize: 30),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Colors.pink.shade100,
                ),
              ),
            )
          ],
        ),
      ),
    );
    tmp.add(card);
  }
  return tmp;
}

class TimeLine {
  final int id;
  final String year;
  final String month;
  final String day;

  TimeLine({
    required this.id,
    required this.year,
    required this.month,
    required this.day,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'year': year,
      'month': month,
      'day': day,
    };
  }

  @override
  String toString() {
    return '$year-$month-$day';
  }
}
