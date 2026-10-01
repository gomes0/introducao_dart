import 'package:flutter/material.dart';
import 'package:consulta_cep_flutter/views/endereco-view.dart';

void main() {
  runApp(const ConsultaCEPApp());
}

class ConsultaCEPApp extends StatelessWidget {
  const ConsultaCEPApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consulta CEP',
      
      // Configuração do Tema Moderno (Material 3)
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.light,
        
        // Estilização global para inputs e botões
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      
      home: const EnderecoView(),
    );
  }
}