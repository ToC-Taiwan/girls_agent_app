import 'package:floor/floor.dart';
import 'package:girls_agent_app/models/timeline.dart';

@dao
abstract class TimeLineDao {
  @Query('SELECT * FROM time_line')
  Future<List<TimeLine>> getAllTimeLine();

  @Query('SELECT * FROM time_line WHERE id = :id')
  Stream<TimeLine?> getTimeLineByID(int id);

  @Insert()
  Future<void> insertTimeLine(TimeLine t);
}
