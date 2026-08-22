void main(List<String> args) {
  print("Inclua os dados do aluno no formato Nome|Idade|Curso|UF");
  final alunos = [];
  alunos.add("João|25|Desenvolvimento de Sistemas|SP");
  alunos.add("Maria|19|Reflexologia|RJ");
  alunos.add("José|50|Administracao|ES");

  print(alunos[0]);
  final aluno = alunos[0].toString().split("|");
  print(
    "\nNome: ${aluno[0]} Idade: ${aluno[1]} Curso: ${aluno[2]} UF: ${aluno[3]}",
  );

  //Utilizando foreach
  alunos.forEach((item) {
    final dados = item.toString().split("|");
    print(
      "Nome: ${dados[0]} | Idade: ${dados[1]} | Curso: ${dados[2]} | UF: ${dados[3]}",
    );
  });

  //Adiciona o estudante abaixo no final da lista
  //"Samira|63|Podologia|SP"
  alunos.add("Samira|63|Podologia|SP");
  print(alunos);

  //Adiciona o estudante abaixo na 2º Posição da Lista
  //"Joaquin|36|TST|RS"
  alunos.insert(1, "Joaquin|36|TST|RS");
  print(alunos);

  //Remover a "Maria|19|Reflexologia|RJ" da lista
  alunos.remove("Maria|19|Reflexologia|RJ");
  print(alunos);

  //Remover o 3º item da lista
  alunos.removeAt(2);
  print(alunos);
}
