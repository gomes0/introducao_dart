import 'dart:convert';
import 'package:consultacep/execeptions/api-invalida-exception.dart';
import 'package:consultacep/execeptions/cep-invalido-exception.dart';
import 'package:consultacep/execeptions/cep-nao-encontrado-exception.dart';
import 'package:consultacep/models/endereco.dart';
import 'package:http/http.dart' as http;

class EnderecoController {
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
    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');

    //Declaro a variável resposta fora do bloco try/catch para que ela possa ser acessada fora do bloco
    final resposta;
    try {
      //Inicializo a variável resposta com o resultado da requisição HTTP
      resposta = await http.get(url);
    } catch (e) {
      // throw Exception('Erro na url ${e.toString()}');
      throw ApiInvalidaException('Erro na url ${e}');
    }

    //Status Code 200 = Consulta realizada com sucesso
    if (resposta.statusCode == 200) {
      Map<String, dynamic> cep = jsonDecode(resposta.body);

      //A Api não localizou o CEP, então retorna um erro
      if (cep.containsKey('erro') && cep['erro'] == 'true') {
        //Lança uma exceção com a mensagem de erro
        throw CepNaoEncontradoException();
      } else {
        //Converte o JSON em um objeto do tipo Endereco e retorna
        return Endereco.fromJson(cep);
      }
    } else {
      //Se o status code for diferente de 200, lança uma exceção com a mensagem de erro
      // throw Exception("Erro na busca do endereço: ${resposta.statusCode}");
      throw ApiInvalidaException(
        "Erro na busca do endereço: ${resposta.statusCode}",
      );
    }
  }
}
