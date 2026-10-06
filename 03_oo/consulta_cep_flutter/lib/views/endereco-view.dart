import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/endereco-controller.dart';
import '../models/endereco.dart';
import '../models/localizacao.dart';

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

  @override
  void initState() {
    super.initState();

    cepController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    cepController.dispose();
    super.dispose();
  }

  void limparTudo() {
    cepController.clear();

    setState(() {
      endereco = null;
      localizacao = null;
      mensagemErro = null;
      localizacaoIndisponivel = false;
      carregando = false;
    });
  }

  Future<void> consultarCEP() async {
    FocusScope.of(context).unfocus();

    setState(() {
      carregando = true;
      mensagemErro = null;
      endereco = null;
      localizacao = null;
      localizacaoIndisponivel = false;
    });

    try {
      // Valida o CEP
      final String cep = enderecoController.validaCEP(cepController.text);

      // Busca o endereço
      final Endereco resultadoEndereco = await enderecoController
          .buscarEndereco(cep);

      if (!mounted) return;

      setState(() {
        endereco = resultadoEndereco;
      });

      // Busca a localização
      try {
        final Localizacao resultadoLocalizacao = await enderecoController
            .buscarLocalizacao(cep);

        if (!mounted) return;

        setState(() {
          localizacao = resultadoLocalizacao;
          localizacaoIndisponivel = false;
        });
      } catch (e) {
        if (!mounted) return;

        setState(() {
          localizacao = null;
          localizacaoIndisponivel = true;
        });
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        mensagemErro = e.toString();
      });
    } finally {
      if (!mounted) return;

      setState(() {
        carregando = false;
      });
    }
  }

  Widget _construirLocalizacao() {
    if (localizacao == null) {
      return const SizedBox.shrink();
    }

    final double? latitude = double.tryParse(
      localizacao!.latitude.replaceAll(',', '.'),
    );

    final double? longitude = double.tryParse(
      localizacao!.longitude.replaceAll(',', '.'),
    );

    if (latitude == null || longitude == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Localização indisponível.',
          textAlign: TextAlign.center,
        ),
      );
    }

    final LatLng coordenada = LatLng(latitude, longitude);

    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      clipBehavior: Clip.antiAlias,
      child: FlutterMap(
        options: MapOptions(initialCenter: coordenada, initialZoom: 15),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'br.com.senac.consultacep',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: coordenada,
                width: 50,
                height: 50,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 45,
                ),
              ),
            ],
          ),
        ],
      ),
    );
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            // =========================
            // CAMPO DO CEP
            // =========================
            TextField(
              controller: cepController,
              keyboardType: TextInputType.number,
              maxLength: 8,

              decoration: InputDecoration(
                labelText: 'CEP',
                hintText: '00000000',
                counterText: '',
                border: const OutlineInputBorder(),

                suffixIcon: cepController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: limparTudo,
                      )
                    : null,
              ),

              textInputAction: TextInputAction.search,

              onSubmitted: (_) => consultarCEP(),

              onChanged: (valor) {
                setState(() {});
              },
            ),

            const SizedBox(height: 16),

            // =========================
            // BOTÕES
            // =========================
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: carregando ? null : consultarCEP,

                    child: const Text('Consultar'),
                  ),
                ),

                if (cepController.text.isNotEmpty || endereco != null) ...[
                  const SizedBox(width: 8),

                  OutlinedButton.icon(
                    onPressed: limparTudo,

                    icon: const Icon(Icons.delete_outline, size: 18),

                    label: const Text('Limpar'),
                  ),
                ],
              ],
            ),

            // =========================
            // CARREGANDO
            // =========================
            if (carregando) ...[
              const SizedBox(height: 24),

              const Center(child: CircularProgressIndicator()),
            ],

            // =========================
            // ERRO
            // =========================
            if (mensagemErro != null && !carregando) ...[
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.red.shade200),
                ),

                child: Text(
                  mensagemErro!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ],

            // =========================
            // ENDEREÇO
            // =========================
            if (endereco != null && !carregando) ...[
              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      'Endereço encontrado',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      'Logradouro: ${endereco!.logradouro}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text('Bairro: ${endereco!.bairro}'),

                    const SizedBox(height: 6),

                    Text('Cidade: ${endereco!.localidade}'),

                    const SizedBox(height: 6),

                    Text('UF: ${endereco!.uf}'),

                    const SizedBox(height: 6),

                    Text('CEP: ${endereco!.cep}'),

                    // =====================
                    // LOCALIZAÇÃO
                    // =====================
                    if (localizacao != null) ...[
                      const SizedBox(height: 20),

                      const Text(
                        'Localização',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text('Latitude: ${localizacao!.latitude}'),

                            const SizedBox(height: 4),

                            Text('Longitude: ${localizacao!.longitude}'),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      _construirLocalizacao(),
                    ],

                    // =====================
                    // LOCALIZAÇÃO INDISPONÍVEL
                    // =====================
                    if (localizacaoIndisponivel) ...[
                      const SizedBox(height: 16),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: const Text(
                          'Coordenadas de localização indisponíveis para este CEP.',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
