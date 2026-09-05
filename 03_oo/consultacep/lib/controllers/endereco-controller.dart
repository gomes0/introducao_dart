import 'dart:convert';
import 'package:consultacep/models/endereco.dart';
import 'package:http/http.dart' as http;

class EnderecoController {
  Future<Endereco> buscarEndereco(String cep) async {
    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');

    //Declaro a variável resposta fora do bloco try/catch para que ela possa ser acessada fora do bloco
    final resposta;
    try {
      //Inicializo a variável resposta com o resultado da requisição HTTP
      resposta = await http.get(url);
    } catch (e) {
      throw Exception('Erro na url ${e.toString()}');
    }

    //Status Code 200 = Consulta realizada com sucesso
    if (resposta.statusCode == 200) {
      Map<String, dynamic> cep = jsonDecode(resposta.body);

      //A Api não localizou o CEP, então retorna um erro
      if (cep.containsKey('erro') && cep['erro'] == 'true') {
        //Lança uma exceção com a mensagem de erro
        throw Exception('CEP não encontrado!!!');
      } else {
        //Converte o JSON em um objeto do tipo Endereco e retorna
        return Endereco.fromJson(cep);
      }
    } else {
      //Se o status code for diferente de 200, lança uma exceção com a mensagem de erro
      throw Exception("Erro na busca do endereço: ${resposta.statusCode}");
    }
  }
}
