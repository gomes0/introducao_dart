// Implements: deve ser utilizada para criar uma herança de uma classe abstract interface

class CepNaoEncontradoException implements Exception {
  @override
  String toString() {
    return "CEP não encontrado!!!";
  }
}
