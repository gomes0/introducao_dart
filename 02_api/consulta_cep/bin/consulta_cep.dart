import 'package:consulta_cep/consulta_cep.dart' as consulta_cep;
import 'package:http/http.dart' as http;
import 'dart:convert';

//Dart pub add http (importa o pacote do pub.dev)
//Declara o http para utilização na classe/função
Future<void> main(List<String> args) async {
  //Future: resultado que ainda vai chegar
  //Async: permite usar o await dentro da função/método
  //Await: espera o resultado

  //final url = Uri.parse('https://viacep.com.br/ws/17509060/json');
  final url = Uri.parse('https://viacep.com.br/ws/17509040/json');

  final resposta = await http.get(url);

  if (resposta.statusCode == 200) {
    //Decodifica o corpo da resposta (String) para um Map
    final Map<String, dynamic> dados = jsonDecode(resposta.body);
    // print(resposta.body);
    //Imprimir apenas os seguintes campos:
    //- Logradouro
    //- Bairro
    //- Cidade
    //- UF
    if (dados.containsKey('erro')) {
      print("CEP inexistente!");
      return;
    }

    //Print
    print('Logradouro: ${dados['logradouro']}');
    print('Bairro: ${dados['bairro']}');
    print('Cidade: ${dados['localidade']}');
    print('UF: ${dados['uf']}');
  } else {
    print("Erro no servidor ou CEP com formato inválido!");
  }
} 
  // else {
  //   print("CEP invalido ou inexistente!");
  // }
  // O ViaCEP retorna {"erro": "true"} caso o número do CEP seja válido mas não exista

