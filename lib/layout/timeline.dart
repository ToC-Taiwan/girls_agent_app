import 'package:flutter/material.dart';
import 'package:girls_agent_app/database.dart';
import 'package:girls_agent_app/models/timeline.dart';
// import 'package:girls_agent_app/generated/l10n.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({Key? key, required this.db}) : super(key: key);
  final AppDatabase db;

  @override
  _GearPageState createState() => _GearPageState();
}

class _GearPageState extends State<TimeLinePage> {
  late Future<List<TimeLine>> futureTimeLine;

  @override
  void initState() {
    super.initState();
    doInsert();
    futureTimeLine = widget.db.timeLineDao.getAllTimeLine();
  }

  DateTime today = DateTime.now();

  void doInsert() async {
    var i = 1;
    while (i <= 30) {
      var lastTime = await widget.db.timeLineDao.getLastTimeLine();
      i++;
      setState(() {
        var last = lastTime ?? TimeLine(today.year.toString(), today.month.toString(), today.day.toString());
        today = DateTime(int.parse(last.year), int.parse(last.month), int.parse(last.day));
        today = today.add(const Duration(days: -1));
      });

      final t = TimeLine(today.year.toString(), today.month.toString(), today.day.toString());
      await widget.db.timeLineDao.insertTimeLine(t);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TimeLine>>(
      future: futureTimeLine,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var tmp = <TimeLine>[];
          tmp = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.only(top: 8),
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
  var tmp = <Widget>[];
  for (final element in arr) {
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
              child: DecoratedBox(
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
                                getMonth(element.getIntMonth()),
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
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Colors.grey.shade100,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          '🤣',
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          '😇',
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          '😌',
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          '🥳',
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          '😋',
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          '😛',
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          '😃',
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          '😃',
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
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

String getMonth(int intMonth) {
  switch (intMonth) {
    case 1:
      return 'JAN';
    case 2:
      return 'FEB';
    case 3:
      return 'MAR';
    case 4:
      return 'APR';
    case 5:
      return 'MAY';
    case 6:
      return 'JUN';
    case 7:
      return 'JUL';
    case 8:
      return 'AUG';
    case 9:
      return 'SEP';
    case 10:
      return 'OCT';
    case 11:
      return 'NOV';
    case 12:
      return 'DEC';
  }
  return '';
}
