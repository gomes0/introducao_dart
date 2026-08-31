class Carros {
  String fabricante;
  String modelo;
  int anoFabricacao;
  int anoModelo;
  bool temABS;

  //Construtor Obrigado
  Carros({
    required this.fabricante,
    required this.modelo,
    required this.anoFabricacao,
    required this.anoModelo,
    required this.temABS,
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
}
