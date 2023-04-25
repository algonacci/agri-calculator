import 'package:agri_calculator/button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/fertilizer_calculator");
                },
                child: const Button(
                  text: "Kalkulator Pupuk",
                  icon: Icons.compost,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/soil_fertility_prediction");
                },
                child: const Button(
                  text: "Soil Fertility Prediction",
                  icon: Icons.eco,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
