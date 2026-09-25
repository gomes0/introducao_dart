import 'package:flutter/material.dart';

class EnderecoView extends StatefulWidget {
  const EnderecoView({super.key});

  @override
  State<StatefulWidget> createState() => _EnderecoViewState();
}

class _EnderecoViewState extends State<EnderecoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Consulta CEP")),
      body: const Center(child: Text("Consulta de Endereço")),
    );
  }
}
