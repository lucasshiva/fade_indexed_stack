import 'package:fade_indexed_stack/fade_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const String widgetText = "Hello, world";
const int pageCount = 3;

void main() {
  testWidgets(
      "FadeIndexedStack loads only one page when [lazy] is set to True.", (
    WidgetTester tester,
  ) async {
    await testFadeIndexedStack(tester, lazy: true);
  });

  testWidgets('FadeIndexedStack loads all pages when [lazy] is set to False.', (
    WidgetTester tester,
  ) async {
    await testFadeIndexedStack(tester, lazy: false);
  });

  // TODO: Test the animation.
}

Future<void> testFadeIndexedStack(
  WidgetTester tester, {
  required bool lazy,
}) async {
  final widget = FadeIndexedStack(
    lazy: lazy,
    children: _getPages(pageCount),
  );

  await tester.pumpWidget(
    Directionality(textDirection: TextDirection.ltr, child: widget),
  );

  expect(
    find.text(widgetText, skipOffstage: false),
    // If lazy loading, there should be only widget.
    lazy ? findsOneWidget : findsNWidgets(pageCount),
  );
}

List<Widget> _getPages(int pageCount) {
  return List.generate(pageCount, (_) => _buildWidget());
}

Widget _buildWidget() {
  return const Center(child: Text(widgetText));
}
