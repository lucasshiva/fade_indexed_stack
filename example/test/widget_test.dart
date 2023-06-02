// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Loads page 2 after NavigationDestination is tapped', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Home Page', skipOffstage: false), findsOneWidget);
    expect(find.text('Profile Page', skipOffstage: false), findsNothing);
    expect(find.text('Settings Page', skipOffstage: false), findsNothing);

    await tester.tap(find.byIcon(Icons.person));
    await tester.pump();

    expect(find.text('Home Page', skipOffstage: false), findsOneWidget);
    expect(find.text('Profile Page', skipOffstage: false), findsOneWidget);
    expect(find.text('Settings Page', skipOffstage: false), findsNothing);
  });
}
