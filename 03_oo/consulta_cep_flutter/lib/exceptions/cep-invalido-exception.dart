class CepInvalidoException implements Exception {
  @override
  String toString() {
    return "CEP inválido, deve possuir 8 números.";
  }
}
