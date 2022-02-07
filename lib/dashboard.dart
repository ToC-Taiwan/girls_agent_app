import 'package:flutter/material.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:girls_agent_app/generated/l10n.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<Database> getConnection() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'girls_agent_app.db'),
    );
    return database;
  }

  Future<void> insertDog(Dog dog) async {
    final db = await getConnection();
    await db.insert(
      'dashboard',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Dog>> dogs() async {
    final db = await getConnection();
    final List<Map<String, dynamic>> maps = await db.query('dashboard');
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
      name: 'Dog Name',
      age: 35,
    );
    await insertDog(fido);
  }

  @override
  Widget build(BuildContext context) {
    doInsert();
    var data = dogs();
    return Center(
      child: Column(
        children: [
          Text(
            S.of(context).dashboard,
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          FutureBuilder<List<Dog>>(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Dog> tmp = [];
                tmp = snapshot.data!;
                return Text(tmp[0].toString());
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
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
