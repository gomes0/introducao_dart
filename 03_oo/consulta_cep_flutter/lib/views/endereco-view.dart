import '../models/endereco.dart';
import '../models/localizacao.dart';

import '../controllers/endereco-controller.dart';
import 'package:flutter/material.dart';

class EnderecoView extends StatefulWidget {
  const EnderecoView({super.key});

  @override
  State<EnderecoView> createState() => _EnderecoViewState();
}

class _EnderecoViewState extends State<EnderecoView> {
  final TextEditingController cepController = TextEditingController();

  final EnderecoController enderecoController = EnderecoController();

  Endereco? endereco;
  Localizacao? localizacao;

  String? mensagemErro;

  bool carregando = false;
  bool localizacaoIndisponivel = false;

  Future<void> consultarCEP() async {
    try {
      setState(() {
        carregando = true;
        mensagemErro = null;
        endereco = null;
        localizacao = null;
        localizacaoIndisponivel = false;
      });

      final String cep =
          enderecoController.validaCEP(cepController.text);

      // Consulta o endereço
      final Endereco enderecoEncontrado =
          await enderecoController.buscarEndereco(cep);

      setState(() {
        endereco = enderecoEncontrado;
      });

      // Consulta a localização separadamente
      try {
        final Localizacao localizacaoEncontrada =
            await enderecoController.buscarLocalizacao(cep);

        setState(() {
          localizacao = localizacaoEncontrada;
        });
      } catch (e) {
        setState(() {
          localizacaoIndisponivel = true;
        });
      }
    } catch (e) {
      setState(() {
        mensagemErro = e.toString();
        endereco = null;
        localizacao = null;
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

                suffixIcon: cepController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),

                        onPressed: () {
                          cepController.clear();

                          setState(() {
                            endereco = null;
                            localizacao = null;
                            mensagemErro = null;
                            localizacaoIndisponivel = false;
                          });
                        },
                      )
                    : null,
              ),

              onChanged: (_) {
                setState(() {});
              },
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: carregando ? null : consultarCEP,
              child: const Text('Consultar'),
            ),

            if (carregando) ...[
              const SizedBox(height: 24),

              const Center(
                child: CircularProgressIndicator(),
              ),
            ],

            if (mensagemErro != null) ...[
              const SizedBox(height: 16),

              Text(
                mensagemErro!,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ],

            if (endereco != null) ...[
              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(vertical: 8.0),

                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Text(
                      'Logradouro: ${endereco!.logradouro}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Bairro: ${endereco!.bairro}',
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Cidade: ${endereco!.localidade}',
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'UF: ${endereco!.uf}',
                    ),
                  ],
                ),
              ),
            ],

            if (localizacao != null) ...[
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      'Localização',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Latitude: ${localizacao!.latitude}',
                    ),

                    Text(
                      'Longitude: ${localizacao!.longitude}',
                    ),
                  ],
                ),
              ),
            ],

            if (localizacaoIndisponivel) ...[
              const SizedBox(height: 16),

              const Text(
                'Localização não disponível para este CEP.',
                style: TextStyle(
                  color: Colors.orange,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}