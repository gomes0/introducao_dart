import 'animal.dart';
import 'tratamento.dart';

class Veterinario {
  String nome;
  Veterinario({required this.nome});

  void atender(Animal animal, Tratamento tratamento) {
    print(
      'Veterinário $nome está atendendo o animal ${animal.nome}. \nCom o tratamento: ${tratamento.descricao}.',
    );
  }
}
