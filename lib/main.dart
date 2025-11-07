import 'package:flutter/material.dart';
import 'screens/start_screen.dart';


void main() {
  runApp(const RelaxFlowApp());
}


class RelaxFlowApp extends StatelessWidget {
  const RelaxFlowApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relax Flow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
        brightness: Brightness.light,
      ),
      home: const StartScreen(),
    );
  }
}