import 'package:floor/floor.dart';
import 'package:girls_agent_app/models/base.dart';

@Entity(tableName: 'time_line')
class TimeLine extends BaseObject {
  TimeLine(
    this.year,
    this.month,
    this.day, {
    int? id,
    int? createTime,
    int? updateTime,
  }) : super(id: id, updateTime: updateTime, createTime: createTime);

  @ColumnInfo(name: 'year')
  final String year;

  @ColumnInfo(name: 'month')
  final String month;

  @ColumnInfo(name: 'day')
  final String day;
}
