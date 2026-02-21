import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/patient_provider.dart';
import 'theme/app_theme.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PatientProvider())],
      child: const VytalApp(),
    ),
  );
}

class VytalApp extends StatelessWidget {
  const VytalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vytal',
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
