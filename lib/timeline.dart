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

  Future<void> insertDog(Dog dog) async {
    final db = await getConnection();
    await db.insert(
      'timeline',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Dog>> dogs() async {
    final db = await getConnection();
    final List<Map<String, dynamic>> maps = await db.query('timeline');
    return List.generate(maps.length, (i) {
      return Dog(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }

  void doInsert() async {
    var fido = Dog(
      id: 0,
      name: 'TimeLine',
      age: 35,
    );
    await insertDog(fido);
  }

  @override
  Widget build(BuildContext context) {
    // doInsert();
    // var data = dogs();
    return ListView(
      shrinkWrap: true,
      // children: [
      //   Card(
      //     color: Colors.white,
      //     child: SizedBox(
      //       height: 100.0,
      //       child: Stack(
      //         children: <Widget>[
      //           Positioned.fill(
      //             child: Image.asset(
      //               'assets/material_design_4.jpg',
      //               fit: BoxFit.cover,
      //             ),
      //           ),
      //           const Positioned(
      //             left: 16.0,
      //             top: 16.0,
      //             child: FittedBox(
      //               fit: BoxFit.cover,
      //               alignment: Alignment.centerLeft,
      //               child: Text(
      //                 '2021-02-06',
      //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      //               ),
      //             ),
      //           ),
      //           const Positioned(
      //             bottom: 16.0,
      //             left: 16.0,
      //             child: FittedBox(
      //               fit: BoxFit.cover,
      //               alignment: Alignment.centerLeft,
      //               child: Text(
      //                 '34 years 4 months',
      //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      //               ),
      //             ),
      //           ),
      //           const Positioned(
      //             top: 16.0,
      //             // left: 16.0,
      //             right: 16.0,
      //             child: Icon(
      //               Icons.bloodtype,
      //               color: Colors.red,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      //   // FutureBuilder<List<Dog>>(
      //   //   future: data,
      //   //   builder: (context, snapshot) {
      //   //     if (snapshot.hasData) {
      //   //       List<Dog> tmp = [];
      //   //       tmp = snapshot.data!;
      //   //       return Text(tmp[0].toString());
      //   //     } else if (snapshot.hasError) {
      //   //       return Text('${snapshot.error}');
      //   //     }
      //   //     return const CircularProgressIndicator();
      //   //   },
      //   // ),
      // ],
      children: timeLineGenerator(20),
    );
  }
}

List<Widget> timeLineGenerator(int count) {
  List<Widget> tmp = [];
  while (tmp.length < count) {
    var card = Card(
      // color: Colors.white,
      child: SizedBox(
        height: 100.0,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                'assets/material_design_4.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const Positioned(
              left: 16.0,
              top: 16.0,
              child: FittedBox(
                fit: BoxFit.cover,
                alignment: Alignment.centerLeft,
                child: Text(
                  '2021-02-06',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
            ),
            const Positioned(
              bottom: 16.0,
              left: 16.0,
              child: FittedBox(
                fit: BoxFit.cover,
                alignment: Alignment.centerLeft,
                child: Text(
                  '34 years 4 months',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
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

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({
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
    return 'Dog{id: $id, name: $name, age: $age}';
  }
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
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
