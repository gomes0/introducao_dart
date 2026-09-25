import 'package:flutter/material.dart';

void main() {
  runApp(const ConsultaCEPApp());
}

class ConsultaCEPApp extends StatelessWidget {
  const ConsultaCEPApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Consulta CEP")),

        body: const Center(child: Text("Meu Primeiro Aplicativo Flutter")),
      ),
    );
  }
}
