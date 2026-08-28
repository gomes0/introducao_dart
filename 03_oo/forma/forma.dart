import 'enum.dart';

abstract class Forma {
  tpForma tipoForma;

  //Declarando construção
  // Forma(tpForma varForma) {
  //  this.tipoForma = varForma;
  //}

  Forma(this.tipoForma);

  //declarando um método abstrato
  double calculaArea();

  //declarando um método de instancia (concreto)
  void imprimeForma() {
    //Quando a variavel de instancia é nullable (?)
    //Deve ser verificado se ela está nula

    // if (tipoForma != null) {
    //   print("${tipoForma!.name} com área de ${calculaArea()}");
    // }

    print("${tipoForma!.name} com área de ${calculaArea()}");
  }
}
