

import 'package:app/screens/registration_screen.dart';
// import 'package:task_sqf/main.dart'; // Corrected import
// import 'package:task_sqf/screens/registration_screen.dart'; // Added import for RegisterScreen
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('RegisterScreen widget test', (WidgetTester tester) async {
    // Build the RegisterScreen wrapped in MaterialApp and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: RegisterScreen()));

    // Verify that the Register button is present.
    expect(find.text('Register'), findsOneWidget);

    // Verify that the text fields for Name, Address, and Password are present.
    expect(find.byType(TextField), findsNWidgets(3));
  });
}
