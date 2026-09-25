class CepInvalidoException implements Exception {
  // final String mensagem;
  // CepInvalidoException(this.mensagem);

  @override
  String toString() {
    return 'CEP Invalido, deve possuir 8 números. \nPreste atenção na máscara de informação.';
  }
}
