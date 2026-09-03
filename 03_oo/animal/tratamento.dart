import 'veterinario.dart';

class Tratamento {
  String? descricao;

  Tratamento({required this.descricao});

  @override
  String toString() {
    return 'Tratamento: $descricao';
  }
}
