import 'padrao.dart' as padrao;
import 'com_parametro.dart' as com_parametro;

void main(List<String> args) {
  //Criando uma instancia de uma classe com construtor padrão
  final carroGTR = padrao.Carros();
  carroGTR.fabricante = "Nissan";
  carroGTR.modelo = "GTR";
  carroGTR.anoFabricacao = 2012;
  carroGTR.anoModelo = 2011;
  carroGTR.temABS = true;
  carroGTR.imprimeDados();

  print("\nCriando uma instancia de ma classe com construtor com parâmetros");
  final carroGTR1 = com_parametro.Carros("Nissan", "GTR", 2012, 2011, true);
  carroGTR.imprimeDados();
}
