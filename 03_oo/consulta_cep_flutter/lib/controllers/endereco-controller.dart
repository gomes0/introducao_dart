import 'dart:convert';
import '../execeptions/api-invalida-exception.dart';
import '../execeptions/cep-invalido-exception.dart';
import '../execeptions/cep-nao-encontrado-exception.dart';
import '../models/endereco.dart';
import '../service/CEPService.dart';
import 'package:http/http.dart' as http;

class EnderecoController {
  
  CEPService cepService = CEPService();

  String validaCEP(String? cep) {
    //Se o CEP digitado for nulo ou em branco, retorna uma exceção
    if (cep == null || cep.isEmpty) {
      //throw Exception('CEP Invalido!!! Tente Novamene...');
      throw CepInvalidoException();
    } else {
      //Retira todos os caracteres e letras, deixando apenas os números
      cep = cep.replaceAll(RegExp(r'[^0-9]'), '');

      //Se a quantidade de números for diferente de 8 retorna uma exeção
      //Caso contrário retorna o CEP sem caracteres ou letras
      if (cep.length != 8) {
        //throw Exception('CEP Invalido, deve possuir 8 números');
        throw CepInvalidoException();
      } else {
        return cep;
      }
    }
  }

  Future<Endereco> buscarEndereco(String cep) async {
    return cepService.consultar(cep);
  }
}
