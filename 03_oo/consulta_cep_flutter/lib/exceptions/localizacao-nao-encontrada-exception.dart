// Implementes deve ser utilizada para criar uma herança de uma classe abstract interface
class LocalizacaoNaoEncontradaException implements Exception {
  @override
  String toString() {
    return 'Não foi possível obter a localização!!!';
  }
}
