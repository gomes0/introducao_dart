//Classe Endereco que representa os dados de um endereço retornado pela API ViaCEP
class Endereco {
  String cep;
  String logradouro;
  String unidade;
  String bairro;
  String localidade;
  String uf;
  String estado;
  String regiao;
  String ibge;
  String gia;
  String ddd;
  String siafi;

  //Construtor da classe Endereco
  Endereco({
    required this.cep,
    required this.logradouro,
    required this.unidade,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.estado,
    required this.regiao,
    required this.ibge,
    required this.gia,
    required this.ddd,
    required this.siafi,
  });

  //Método que converte o objeto Endereco para Json
  Map<String, dynamic> paraJson() {
    return {
      'cep': this.cep,
      'logradouro': this.logradouro,
      'unidade': this.unidade,
      'bairro': this.bairro,
      'localidade': this.localidade,
      'uf': this.uf,
      'estado': this.estado,
      'regiao': this.regiao,
      'ibge': this.ibge,
      'gia': this.gia,
      'ddd': this.ddd,
      'siafi': this.siafi,
    };
  }

  //Metodo para transformar o JSon em um objeto Endereco
  //factory (fábrica) é um especial de construtor que permite controlar qual instancia será retornada
  factory Endereco.fromJson(Map<String, dynamic> json) {
    return Endereco(
      cep: json['cep'],
      logradouro: json['logradouro'],
      unidade: json['unidade'],
      bairro: json['bairro'],
      localidade: json['localidade'],
      uf: json['uf'],
      estado: json['estado'],
      regiao: json['regiao'],
      ibge: json['ibge'],
      gia: json['gia'],
      ddd: json['ddd'],
      siafi: json['siafi'],
    );
  }
}
