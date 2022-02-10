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
    final List<Map<String, dynamic>> maps = await db.query('timeline');
    return List.generate(maps.length, (i) {
      return TimeLine(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }

  void doInsert() async {
    int i = 0;
    while (i < 20) {
      i++;
      var fido = TimeLine(
        id: i,
        name: 'TimeLine $i',
        age: i * 33,
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
          return ListView(
            shrinkWrap: true,
            children: timeLineGenerator(tmp),
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
    String picPath = 'assets/material_design_4.jpg';
    int cond = element.id % 2;
    if (cond != 0) {
      picPath = 'assets/material_design_3.png';
    }
    var card = Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: SizedBox(
        height: 100.0,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                picPath,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              left: 16.0,
              top: 16.0,
              child: FittedBox(
                fit: BoxFit.cover,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Event ' + element.id.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
            ),
            Positioned(
              bottom: 16.0,
              left: 16.0,
              child: FittedBox(
                fit: BoxFit.cover,
                alignment: Alignment.centerLeft,
                child: Text(
                  element.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                ),
              ),
            ),
            const Positioned(
              top: 16.0,
              right: 16.0,
              child: Icon(
                Icons.bloodtype,
                color: Colors.red,
              ),
            ),
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
  final String name;
  final int age;

  TimeLine({
    required this.id,
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  @override
  String toString() {
    return '$name, age: $age';
  }
}
