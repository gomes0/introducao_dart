import 'Forma.dart';
import 'enum.dart';

//Herança / Especialização
//Classe Quadrado herda os membros (variáveis e métodos) de Forma
class Quadrado extends Forma {
  double lado;

  //Construtor da Classe Quadrado
  //Chamando o construtor da classe pai
  Quadrado(this.lado) : super(tpForma.Quadrado);

  //Sobrescrever o método abstrato da classe pai
  @override
  double calculaArea() {
    return lado * lado;
  }
}
