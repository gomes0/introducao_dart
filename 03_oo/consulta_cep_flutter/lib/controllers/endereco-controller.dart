import '../models/localizacao.dart';
import '../service/localizacaoService.dart';

import '../exceptions/api-invalida-exception.dart';
import '../exceptions/cep-invalido-exception.dart';
import '../exceptions/localizacao-nao-encontrada-exception.dart';
import '../models/endereco.dart';
import '../service/CEPService.dart';

class EnderecoController {
  final CEPService cepservice = CEPService();

  Localizacaoservice localizacaoservice = Localizacaoservice();

  String validaCEP(String? cep) {
    if (cep == null || cep.trim().isEmpty) {
      throw CepInvalidoException();
    }

    // Remove qualquer caractere que NÃO seja um número de 0 a 9
    String cepApenasNumeros = cep.replaceAll(RegExp(r'[^0-9]'), '');

    // Se a quantidade de números for diferente de 8, lança exceção
    if (cepApenasNumeros.length != 8) {
      throw CepInvalidoException();
    }

    return cepApenasNumeros;
  }

  Future<Endereco> buscarEndereco(String cep) async {
    return cepservice.consultar(cep);
  }

  Future<Localizacao> buscarLocalizacao(String cep) async {
    return Localizacaoservice().consultar(cep);
  }
}
