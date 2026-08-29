import 'forma.dart';
import 'enum.dart';

//Herança / Especialização
//Classe Quadrado herda os membros (variáveis e métodos) de Forma
class Triangulo extends Forma {
  //Variaveis
  double base;
  double altura;

  //Construtor da Classe Quadrado
  //Chamando o construtor da classe pai
  Triangulo(this.base, this.altura) : super(tpForma.Retangulo);

  //Sobrescrever o método abstrato da classe pai
  @override
  double calculaArea() {
    return (base * altura) / 2;
  }
}
