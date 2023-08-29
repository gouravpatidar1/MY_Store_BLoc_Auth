import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_store/home/home.dart';

void main() {
  testWidgets('Displays List of users with title as name ',
   (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomePage(title: '',),
      )
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}