import 'package:consulta_cep_flutter/models/endereco.dart';

import '../controllers/endereco-controller.dart';
import 'package:flutter/material.dart';

class EnderecoView extends StatefulWidget {
  const EnderecoView({super.key});

  @override
  State<StatefulWidget> createState() => _EnderecoViewState();
}

class _EnderecoViewState extends State<EnderecoView> {
  final TextEditingController cepController = TextEditingController();
  final EnderecoController enderecoController = EnderecoController();

  Endereco? endereco;
  String? mensagemErro;
  bool carregando = false;

  Future<void> consultarCEP() async {
    try {
      setState(() {
        carregando = true;
        mensagemErro = null;
        this.endereco = null;
      });

      String cep = enderecoController.validaCEP(cepController.text);

      final endereco = await enderecoController.buscarEndereco(cep);

      setState(() {
        this.endereco = endereco;
      });
    } catch (e) {
      setState(() {
        mensagemErro = e.toString();
        endereco = null;
      });
    } finally {
      setState(() {
        carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ConsultaCEP'),
        centerTitle: true, 
        backgroundColor: Colors.purple.shade900, 
        foregroundColor: Colors.white, 
        elevation: 4.0, 
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            TextField(
              controller: cepController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'CEP',
                hintText: '00000-000',
                border: const OutlineInputBorder(),
                // Exibe o ícone de limpar quando o texto não estiver vazio
                suffixIcon: cepController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          cepController.clear(); // Limpa o texto do campo
                          setState(() {
                            endereco =
                                null; // Opcional: limpa os resultados exibidos na tela
                            mensagemErro = null;
                          });
                        },
                      )
                    : null,
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: consultarCEP,
              child: const Text('Consultar'),
            ),

            if (endereco != null) ...[
              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[20],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Alinha o texto à esquerda
                  mainAxisSize:
                      MainAxisSize.min, // Ocupa apenas o espaço necessário
                  children: [
                    Text(
                      'Logradouro: ${endereco!.logradouro}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0), // Espaço entre as linhas
                    Text('Bairro: ${endereco!.bairro}'),
                    const SizedBox(height: 4.0),
                    Text('Cidade: ${endereco!.localidade}'),
                    const SizedBox(height: 4.0),
                    Text('UF: ${endereco!.uf}'),
                  ],
                ),
              ),
            ],

            if (mensagemErro != null) ...[
              const SizedBox(height: 16),

              Text(mensagemErro!, style: const TextStyle(color: Colors.red)),
            ],

            if (carregando) ...[
              SizedBox(height: 24),

              const Center(child: CircularProgressIndicator()),
            ],
          ],
        ),
      ),
    );
  }
}
