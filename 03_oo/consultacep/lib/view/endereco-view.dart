import 'dart:io';
import 'package:consultacep/controllers/endereco-controller.dart';
import 'package:consultacep/execeptions/api-invalida-exception.dart';
import 'package:consultacep/execeptions/cep-invalido-exception.dart';
import 'package:consultacep/execeptions/cep-nao-encontrado-exception.dart';
import 'package:consultacep/models/endereco.dart';

class EnderecoView {
  // Adicionada a tipagem explícita do controller
  final EnderecoController enderecoController;

  // Construtor simplificado
  EnderecoView() : enderecoController = EnderecoController();

  // Nome do método ajustado para camelCase (boas práticas Dart)
  Future<void> iniciar() async {
    print('Informe o CEP (Formato 00000-000): ');
    String? cep = stdin.readLineSync();

    try {
      // Garante que cep não passe nulo caso o leitor falhe
      String cepValido = enderecoController.validaCEP(cep ?? '');
      Endereco endereco = await enderecoController.buscarEndereco(cepValido);

      print('Logradouro: ${endereco.logradouro}');
      print('Bairro: ${endereco.bairro}');
      print('Município: ${endereco.localidade}');
      print('UF: ${endereco.uf} ${endereco.estado}');
    } on CepNaoEncontradoException catch (e) {
      print(e);
    } on CepInvalidoException catch (e) {
      print("Erro na estrutura do CEP informado:");
      print(e);
    } on ApiInvalidaException catch (e) {
      // Movido para ANTES do catch genérico
      print("Erro na API:");
      print(e);
    } catch (e) {
      // Catch genérico mantido obrigatoriamente no FINAL
      print("Erro inesperado:");
      print(e);
    }
  }
}
