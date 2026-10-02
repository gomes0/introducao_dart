import 'dart:convert';
import '../exceptions/cep-nao-encontrado-exception%20copy.dart';

import '../exceptions/api-invalida-exception.dart';
import '../exceptions/localizacao-nao-encontrada-exception.dart';
import '../models/endereco.dart';
import 'package:http/http.dart' as http;

class CEPService {
  Future<Endereco> consultar(String cep) async {
    final url = Uri.parse('http://viacep.com.br/ws/$cep/json');

    final http.Response resposta;

    try {
      resposta = await http.get(url);
    } catch (e) {
      throw ApiInvalidaException("Erro na url:  $e");
    }

    //Status code 200: Conseguiu consultar a API
    if (resposta.statusCode == 200) {
      Map<String, dynamic> cep = jsonDecode(resposta.body);

      //A api não localizou o CEP. pode ser um CEP inválido ou não consta na base de dados no viacep
      if (cep.containsKey('erro') && cep['erro'] == 'true') {
        //Lança uma exceção com o erro
        throw CepNaoEncontradoException();
      } else {
        //Converte o Json para um objeto endereço
        return Endereco.deJson(cep);
      }
    } else {
      //Se o Status Code for diferente de 200, retorna uma exceção informando o codigo do erro
      throw ApiInvalidaException(
        "Erro na busca do endereço: ${resposta.statusCode}",
      );
    }
  }
}
