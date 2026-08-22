void main(List<String> args) {
  //SET{} não permite valores duplicados
  Set<int?> numeros = {1, 1, 1, 2, 2, 2, 3, 3, 3, 4};
  numeros.forEach(print);

  //Metódo List.toSet transforma uma lista e, um set
  var numerosList = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
  numerosList.forEach(print);

  print("\nLista convertida para SET");
  var numerosSet = numerosList.toSet();
  numerosSet.forEach(print);

  var conjunto1 = {1, 2, 3, 4, 5, 6};
  var conjunto2 = {1, 2, 3, 7};

  //Metódo difference: apresenta apenas itens exclusivos dos dois conjuntos
  print(conjunto1.difference(conjunto2));
  print(conjunto2.difference(conjunto1));

  //Metódo union: junta dois sets
  print(conjunto1.union(conjunto2));

  //Metódo intersection
  print(conjunto1.intersection(conjunto2));

  //LookUp: procura o item no SET, se encontrar retorna o valor, caso contrário retorna null
  var nomes = {"Fulano", "Beltrano", "Sicrano"};
  print(nomes.lookup("Beltrano"));

  //Retorna um item atráves do índice
  print("Segundo item do SET: ${nomes.elementAt(1)}");
}
