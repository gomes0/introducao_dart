void main(List<String> args) {
  //Tipos genericos
  List<int> listaNumeros = [1, 2, 3];

  List<String> listaTextos = ["Fulano", "Beltrano", "Cicrano"];

  //Tipos de lista por inferencia
  var listaNumerosInferencia = [1, 2, 3];

  var listaTextosInferencia = ["Fulano", "Beltrano", "Sicrano"];

  //Lista vazia
  List<int> listSemNumeros = [];
  var listaSemNumerosPorInferencia = <int>[];
  var listaSemTextosPorInferencia = <String>[];

  //NullSafety

  //Tem que iniciar a lista e os itens não podem serr nulos
  List<String> nome;

  //Apresenta porque a lista deve ser inicializada
  //nome = null;

  //Apresenta erro pois a lista não está inicializada
  //print(nome.length);

  nome = [];
  print(nome.length);

  //Apresenta um erro, pois a lista não permite itens nulos
  //nome = ["Fulano", null];

  //Não precisa iniciar a lista, porem os itens não podem se nulos
  List<String>? nomeSemIniciar;
  nomeSemIniciar = null;
  if (nomeSemIniciar != null) ;
  print(nomeSemIniciar?.length);

  //Precisa iniciar a lista prem os itens podem ser nulos
  List<String?> nomeItensNulos;
  //Apresenta erro porque deve inicializar
  //nomeItensNulos = null;

  nomeItensNulos = ["Fulano", null];

  //Não precisa inicializar e os itens podem ser nulos
  List<String?>? nomeSemIniciarItensNulos;
  nomeSemIniciarItensNulos = null;
  nomeSemIniciarItensNulos = ["Fulano", null];

  //Declaração por inferencia
  var nomesItensNulosInferencia = <String?>[null];

  final numeros = [1, 2, 3, 4];
  print(numeros);

  //Metódo add: adiciona um item ao final da lista
  numeros.add(5);
  print(numeros);

  final nomes = ["Fulano", "Beltrano"];
  nomes.add("Sicrano");
  print("1º ${nomes[0]}");
  print("2º ${nomes[1]}");
  print("3º ${nomes[2]}");

  //Metódo insert: adiciona um novo item em uma posição determinada
  nome.insert(0, "Novo primeiro Nome");
  print(nomes);

  //Metódo inserAll: adiciona uma lista em outra
  final nomesNovos = ["João", "Maria"];
  nomes.addAll(nomesNovos);
  print(nomes);

  //Metódo remove: remove um item da lista
  nomes.remove("João");
  print(nomes);
}
