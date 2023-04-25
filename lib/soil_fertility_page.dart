import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SoilFertilityPredictionPage extends StatefulWidget {
  const SoilFertilityPredictionPage({Key? key}) : super(key: key);

  @override
  _SoilFertilityPredictionPageState createState() =>
      _SoilFertilityPredictionPageState();
}

class _SoilFertilityPredictionPageState
    extends State<SoilFertilityPredictionPage> {
  final _formKey = GlobalKey<FormState>();
  final _nitrogenController = TextEditingController();
  final _phosphorusController = TextEditingController();
  final _potassiumController = TextEditingController();
  final _phController = TextEditingController();
  final _moistureController = TextEditingController();
  String _predictionResult = '';

  Future<void> _predictSoilFertility() async {
    final uri =
        Uri.parse('http://192.168.0.107:5000/soil_fertility_prediction');
    final response = await http.post(uri, body: {
      'n': _nitrogenController.text,
      'p': _phosphorusController.text,
      'k': _potassiumController.text,
      'ph': _phController.text,
      'moisture': _moistureController.text,
    });
    final data = jsonDecode(response.body);
    setState(() {
      _predictionResult = data['soil_fertility'];
    });
  }

  @override
  void dispose() {
    _nitrogenController.dispose();
    _phosphorusController.dispose();
    _potassiumController.dispose();
    _phController.dispose();
    _moistureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soil Fertility Prediction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nitrogenController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Kandungan Nitrogen (ppm)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Kandungan Nitrogen tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _phosphorusController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Kandungan Fosforus (ppm)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Kandungan Fosforus tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _potassiumController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Kandungan Kalium (ppm)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Kandungan Kalium tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _phController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'pH',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'pH tidak boleh kosong';
                    } else if (double.tryParse(value) == null) {
                      return 'pH harus berupa angka';
                    } else if (double.parse(value) < 1 ||
                        double.parse(value) > 14) {
                      return 'pH harus berada dalam rentang 1 - 14';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _moistureController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Kelembaban Tanah (%)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Kelembaban Tanah tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _predictSoilFertility();
                    }
                  },
                  child: const Text('Prediksi'),
                ),
                const SizedBox(height: 16.0),
                if (_predictionResult.isNotEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Hasil Prediksi:'),
                          const SizedBox(height: 8.0),
                          Text(_predictionResult),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
