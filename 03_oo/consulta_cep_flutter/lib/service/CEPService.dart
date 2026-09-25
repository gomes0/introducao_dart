import 'dart:convert';

import '../execeptions/api-invalida-exception.dart';
import '../execeptions/cep-nao-encontrado-exception.dart';
import '../models/endereco.dart';
import 'package:http/http.dart' as http;

class CEPService {
  
  Future<Endereco> consultar(String cep) async {
    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');

    late http.Response resposta;

    try {
      resposta = await http.get(url);
    } catch (e) {
      throw ApiInvalidaException('Erro na url $e');
    }

    // Status Code 200 = Consulta realizada com sucesso
    if (resposta.statusCode == 200) {
      Map<String, dynamic> cep = jsonDecode(resposta.body);

      // A API não localizou o CEP
      if (cep.containsKey('erro') && cep['erro'] == true) {
        throw CepNaoEncontradoException();
      } else {
        // Converte o JSON em um objeto do tipo Endereco
        return Endereco.fromJson(cep);
      }
    } else {
      throw ApiInvalidaException(
        'Erro na busca do endereço: ${resposta.statusCode}',
      );
    }
  }
}
