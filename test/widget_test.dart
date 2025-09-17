// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_test_solidsoft/main.dart';

void main() {
  testWidgets('GestureDetector tap smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify text exists
    expect(find.text('Hello there'), findsOneWidget);

    Color startColor = tester.widget<ColoredBox>(find.byType(ColoredBox)).color;
    // Tap anywhere at GestureDetector.
    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    //Wait for animation
    await tester.pump(Durations.short1);

    Color afterTapColor = tester.widget<ColoredBox>(find.byType(ColoredBox)).color;
    expect(afterTapColor, isNot(startColor));
  });
}
