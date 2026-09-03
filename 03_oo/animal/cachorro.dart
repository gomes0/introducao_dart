import 'animal.dart';
import 'alimento.dart';
import 'brinquedo.dart';
import 'especie.dart';

class Cachorro extends Animal {
  int? fofura;
  List<Brinquedo> brinquedos = [];

  Cachorro({
    required String nome,
    required double peso,
    required this.fofura,
    required Alimento alimento,
    required Especie especie,
  }) : super(
          nome: nome,
          peso: peso,
          alimento: alimento,
          especie: especie,
        );

  void incluirBrinquedo(Brinquedo brinquedo) {
    brinquedos.add(brinquedo);
    print('$nome ganhou o brinquedo ${brinquedo.nome}!');
  }

  void brincar(Brinquedo brinquedo) {
    print('$nome está brincando com ${brinquedo.nome}.');
  }

  @override
  void fazerSom() {
    print('Au au!');
  }

  @override
  void comer() {
    print('$nome está comendo ${alimento.tipo}.');
  }

  @override
  String toString() {
    return 'Cachorro: $nome, peso: $peso kg, fofura: $fofura';
  }
}