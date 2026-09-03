import 'animal.dart';
import 'alimento.dart';
import 'especie.dart';

class Gato extends Animal {
  int? ronrom;

  Gato({
    required String nome,
    required double peso,
    required Alimento alimento,
    required Especie especie,
    required this.ronrom,
  }) : super(
          nome: nome,
          peso: peso,
          alimento: alimento,
          especie: especie,
        );

  @override
  void fazerSom() {
    print('Miau!');
  }

  @override
  void comer() {
    print('$nome está comendo ${alimento.tipo}.');
  }

  void fazerCarinho() {
    print('$nome está recebendo carinho.');
  }

  @override
  String toString() {
    return 'Gato: $nome, peso: $peso kg, ronrom: $ronrom';
  }
}