void main(List<String> args) {
  final estudante = <String, String>{
    "nome": "Fulano de tal",
    "curso": "Desenvolvimento de Sistemas",
  };

  print(estudante);

  final escola = <String, Object>{
    "nome": "Senac Marília",
    "cursos": [
      {
        "nome": "Técnico em Desenvolvimento de Sistemas",
        "descricao": "Implementação de sistemas para web e mobile",
      },
      {
        "nome": "Técnico em Segurança do Trabalho",
        "descricao": "Gerenciamento das NRs- Normas Regulamentares",
      },
    ],
  };
  print(escola);
  print("escola: ${escola['nome']}");
  for (var curso in escola["cursos"] as List) {
    print("- ${curso["nome"]} -${curso["descricao"]}");
  }
}
