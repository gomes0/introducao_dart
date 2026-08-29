class Carros {
  String? fabricante;
  String? modelo;
  int? anoFabricacao;
  int? anoModelo;
  bool? temABS;

  //Construtor padrão
  // Carro():super(){
  // }

  void imprimeDados() {
    print(retornaDados());
  }

  String retornaDados() {
    return '''
            Fabricante: ${fabricante}
            Modelo: ${modelo}
            Ano de Fabricação: ${anoFabricacao}
            Ano do Modelo: ${anoModelo}
            Tem ABS: ${temABS == true ? "SIM" : "NÃO"}
          ''';
  }
}
