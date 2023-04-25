import 'package:agri_calculator/fertilizer_calculator_page.dart';
import 'package:agri_calculator/home_page.dart';
import 'package:agri_calculator/soil_fertility_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
      routes: {
        '/fertilizer_calculator': (context) => const FertilizerCalculatorPage(),
        '/soil_fertility_prediction': (context) =>
            const SoilFertilityPredictionPage()
      },
    );
  }
}
