import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FertilizerCalculatorPage extends StatefulWidget {
  const FertilizerCalculatorPage({Key? key}) : super(key: key);

  @override
  _FertilizerCalculatorPageState createState() =>
      _FertilizerCalculatorPageState();
}

class _FertilizerCalculatorPageState extends State<FertilizerCalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final _luasLahanController = TextEditingController();
  String _jenisTanaman = 'padi';
  Map<String, dynamic> _result = {};

  Future<void> _calculateFertilizer() async {
    final uri = Uri.parse('http://192.168.0.107:5000/calculate_fertilizer');
    final response = await http.post(uri, body: {
      'luas_lahan': _luasLahanController.text,
      'jenis_tanaman': _jenisTanaman,
    });
    final data = jsonDecode(response.body);
    setState(() {
      _result = data;
    });
  }

  @override
  void dispose() {
    _luasLahanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Pupuk'),
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
                  controller: _luasLahanController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Luas Lahan (ha)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Luas Lahan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: _jenisTanaman,
                  items: const [
                    DropdownMenuItem(
                      value: 'padi',
                      child: Text('Padi'),
                    ),
                    DropdownMenuItem(
                      value: 'jagung',
                      child: Text('Jagung'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _jenisTanaman = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Jenis Tanaman',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _calculateFertilizer();
                    }
                  },
                  child: const Text('Hitung'),
                ),
                const SizedBox(height: 16.0),
                if (_result.isNotEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Jumlah Pupuk yang Dibutuhkan:'),
                          const SizedBox(height: 8.0),
                          Text('Urea: ${_result['urea']} kg'),
                          Text('SP-36: ${_result['sp36']} kg'),
                          Text('KCl: ${_result['kcl']} kg'),
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
