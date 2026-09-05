import 'dart:io';
import 'package:consultacep/controllers/endereco-controller.dart';
import 'package:consultacep/models/endereco.dart';

void main(List<String> args) async {
  final enderecoController = EnderecoController();

  print('Informe o CEP (Formato 00000-000): ');
  String? cep = stdin.readLineSync();
  // cep = cep!.replaceAll(RegExp(r'[^0-9]'), '');

  try {
    Endereco endereco = await enderecoController.buscarEndereco(validaCEP(cep));
    print('Logradouro: ${endereco.logradouro}');
    print('Bairro: ${endereco.bairro}');
    print('municipio: ${endereco.localidade}');
    print('UF: ${endereco.uf} ${endereco.estado}');
  } catch (e) {
    print(e);
  }
}

String validaCEP(String? cep) {
  //Se o CEP digitado for nulo ou em branco, retorna uma exceção
  if (cep == null || cep.isEmpty) {
    throw Exception('CEP Invalido!!! Tente Novamene...');
  } else {
    //Retira todos os caracteres e letras, deixando apenas os números
    cep = cep.replaceAll(RegExp(r'[^0-9]'), '');

    //Se a quantidade de números for diferente de 8 retorna uma exeção
    //Caso contrário retorna o CEP sem caracteres ou letras
    if (cep.length != 8) {
      throw Exception('CEP Invalido, deve possuir 8 números');
    } else {
      return cep;
    }
  }
}
