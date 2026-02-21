import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:vytal/main.dart';
import 'package:vytal/providers/patient_provider.dart';

void main() {
  testWidgets('Smoke test for Login Screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => PatientProvider())],
        child: const VytalApp(),
      ),
    );

    // Verify that the login screen renders.
    expect(find.text('Login'), findsWidgets);
  });
}
