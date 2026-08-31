class Carros {
  String fabricante;
  String modelo;
  int anoFabricacao;
  int anoModelo;
  bool temABS;

  //Construtor com pârametros
  Carros(
    this.fabricante,
    this.modelo,
    this.anoFabricacao,
    this.anoModelo,
    this.temABS
  );

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
