import 'forma.dart';
import 'enum.dart';
import 'dart:math';

//Herança / Especialização
//Classe Quadrado herda os membros (variáveis e métodos) de Forma
class Circulo extends Forma {
  //Variaveis
  double raio;

  //Construtor da Classe Quadrado
  //Chamando o construtor da classe pai
  Circulo(this.raio) : super(tpForma.Retangulo);

  //Sobrescrever o método abstrato da classe pai
  @override
  double calculaArea() {
    return pi * raio * raio;
  }
}
