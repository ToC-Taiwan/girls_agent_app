import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:girls_agent_app/database.dart';
import 'package:girls_agent_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    final db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    await tester.pumpWidget(GirlsAgentAPP(
      db: db,
    ));

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
