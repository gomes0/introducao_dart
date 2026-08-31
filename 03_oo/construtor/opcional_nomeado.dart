class Carros {
  String fabricante;
  String modelo;
  int anoFabricacao;
  int anoModelo;
  bool temABS;

  //Construtor Opcional
  Carros({
    required this.fabricante,
    required this.modelo,
    this.anoFabricacao = 2012,
    this.anoModelo = 2011,
    this.temABS = true,
  });

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

  @override
  String toString() {
    return retornaDados();
  }
}
