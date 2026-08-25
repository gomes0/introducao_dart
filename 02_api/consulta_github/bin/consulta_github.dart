import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> main(List<String> args) async {
  // Troque pelo nome do usuário do GitHub que deseja consultar
  final meuUsuario = 'gomes0';
  final url = Uri.parse('https://api.github.com/users/$meuUsuario');

  final resposta = await http.get(url);

  if (resposta.statusCode == 200) {
    final Map<String, dynamic> dados = jsonDecode(resposta.body);

    print('=== Meu Perfil no GitHub ===');
    print('Nome: ${dados['name'] ?? 'Não informado'}');
    print('Usuário: ${dados['login']}');
    print('Bio: ${dados['bio'] ?? 'Sem biografia'}');
    print('Repositórios públicos: ${dados['public_repos']}');
    print('Seguidores: ${dados['followers']}');
    print('Seguindo: ${dados['following']}');
    print('Link do Perfil: ${dados['html_url']}');
  } else if (resposta.statusCode == 404) {
    print('Usuário "$meuUsuario" não foi encontrado!');
  } else {
    print('Erro na requisição: ${resposta.statusCode}');
  }
}
