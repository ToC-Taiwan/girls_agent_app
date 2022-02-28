import 'dart:async';

import 'package:floor/floor.dart';
import 'package:girls_agent_app/daos/timeline_dao.dart';
import 'package:girls_agent_app/models/timeline.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [TimeLine])
abstract class AppDatabase extends FloorDatabase {
  TimeLineDao get timeLineDao;
}
