import 'package:consulta_cep_flutter/exceptions/cep-nao-encontrado-exception%20copy.dart';
import 'package:flutter/material.dart';

// Importações do seu projeto (ajuste o caminho se necessário)
import '../controllers/endereco-controller.dart';
import '../exceptions/api-invalida-exception.dart';
import '../exceptions/cep-invalido-exception.dart';
import '../exceptions/localizacao-nao-encontrada-exception.dart';
import '../models/endereco.dart';

class EnderecoView extends StatefulWidget {
  const EnderecoView({super.key});

  @override
  State createState() => _EnderecoViewState();
}

class _EnderecoViewState extends State {
  final TextEditingController _cepController = TextEditingController();
  final EnderecoController _controller = EnderecoController();

  bool _carregando = false;
  String? _mensagemErro;
  Endereco? _endereco;

  Future _consultar() async {
    // Esconde o teclado
    FocusScope.of(context).unfocus();

    setState(() {
      _carregando = true;
      _mensagemErro = null;
      _endereco = null;
    });

    try {
      // 1. Valida o CEP informado usando sua Controller
      final cepValidado = _controller.validaCEP(_cepController.text);

      // 2. Busca o endereço via Service
      final resultado = await _controller.buscarEndereco(cepValidado);

      setState(() {
        _endereco = resultado;
      });
    } on CepInvalidoException {
      setState(() {
        _mensagemErro = 'Digite um CEP válido com 8 dígitos.';
      });
    } on CepNaoEncontradoException {
      setState(() {
        _mensagemErro = 'CEP não encontrado na base de dados.';
      });
    } on ApiInvalidaException catch (e) {
      setState(() {
        _mensagemErro = e.toString();
      });
    } catch (e) {
      setState(() {
        _mensagemErro = 'Ocorreu um erro inesperado ao consultar o CEP.';
      });
    } finally {
      setState(() {
        _carregando = false;
      });
    }
  }

  void _limpar() {
    _cepController.clear();
    setState(() {
      _carregando = false;
      _mensagemErro = null;
      _endereco = null;
    });
  }

  @override
  void dispose() {
    _cepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Consulta CEP'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Card do Formulário de Busca
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _cepController,
                      keyboardType: TextInputType.number,
                      maxLength: 8,
                      decoration: InputDecoration(
                        labelText: 'Informe o CEP',
                        hintText: '00000000',
                        prefixIcon: const Icon(Icons.location_on_outlined),
                        suffixIcon: _cepController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: _limpar,
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        counterText: "",
                      ),
                      onChanged: (val) => setState(() {}),
                      onSubmitted: (_) => _consultar(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _carregando ? null : _consultar,
                            icon: const Icon(Icons.search),
                            label: const Text('Consultar'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton(
                          onPressed: _limpar,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Limpar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Indicador de Carregamento
            if (_carregando)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(),
                ),
              ),

            // Card de Mensagem de Erro
            if (_mensagemErro != null && !_carregando)
              Card(
                color: theme.colorScheme.errorContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: theme.colorScheme.onErrorContainer,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _mensagemErro!,
                          style: TextStyle(
                            color: theme.colorScheme.onErrorContainer,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Card de Exibição dos Dados do Endereço
            if (_endereco != null && !_carregando) ...[
              Text(
                'Endereço Encontrado',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildInfoItem(
                        icon: Icons.map,
                        label: 'Logradouro',
                        value: _endereco!.logradouro.isNotEmpty
                            ? _endereco!.logradouro
                            : '-',
                      ),
                      const Divider(),
                      _buildInfoItem(
                        icon: Icons.location_city,
                        label: 'Bairro',
                        value: _endereco!.bairro.isNotEmpty
                            ? _endereco!.bairro
                            : '-',
                      ),
                      const Divider(),
                      _buildInfoItem(
                        icon: Icons.domain,
                        label: 'Cidade / UF',
                        value: '\({_endereco!.localidade} /\){_endereco!.uf}',
                      ),
                      const Divider(),
                      _buildInfoItem(
                        icon: Icons.pin_drop,
                        label: 'CEP',
                        value: _endereco!.cep,
                      ),
                      if (_endereco!.ddd.isNotEmpty) ...[
                        const Divider(),
                        _buildInfoItem(
                          icon: Icons.phone,
                          label: 'DDD',
                          value: _endereco!.ddd,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
