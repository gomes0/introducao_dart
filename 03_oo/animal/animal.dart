import 'alimento.dart';
import 'especie.dart';

abstract class Animal {
  String nome;
  double peso;
  Alimento alimento;
  Especie especie;

  Animal({
    required this.nome,
    required this.peso,
    required this.alimento,
    required this.especie,
  });

  void fazerSom();
  void comer();
}
