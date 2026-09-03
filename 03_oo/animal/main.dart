import 'animal.dart';
import 'alimento.dart';
import 'brinquedo.dart';
import 'cachorro.dart';
import 'especie.dart';
import 'gato.dart';
import 'tratamento.dart';
import 'veterinario.dart';

void main() {
  //Criando alimentos

  Alimento racao = Alimento(tipo: 'Ração');

  Alimento peixe = Alimento(tipo: 'Peixe');

  //Criando cachorro

  Cachorro cachorro = Cachorro(
    nome: 'Rex',
    peso: 20.5,
    fofura: 10,
    alimento: racao,
    especie: Especie.mamifero,
  );

  //Criando gato

  Gato gato = Gato(
    nome: 'Mingau',
    peso: 5.2,
    ronrom: 8,
    alimento: peixe,
    especie: Especie.mamifero,
  );

  //Criando brinquedos

  Brinquedo bolinha = Brinquedo(nome: 'Bolinha');

  Brinquedo osso = Brinquedo(nome: 'Osso');

  Brinquedo corda = Brinquedo(nome: 'Corda');

  //Adicionando brinquedos ao cachorro
  cachorro.incluirBrinquedo(bolinha);
  cachorro.incluirBrinquedo(osso);
  cachorro.incluirBrinquedo(corda);

  //Prints

  print('========== ANIMAIS ==========');

  print(cachorro);
  print(gato);

  print('\n========== COMER ==========');

  cachorro.comer();
  gato.comer();

  print('\n========== BRINCAR ==========');

  cachorro.brincar(bolinha);
  cachorro.brincar(osso);

  print('\n========== CARINHO ==========');

  gato.fazerCarinho();

  //Criando veterinário

  Veterinario veterinario = Veterinario(nome: 'Dra. Mariana');

  //Criando tratamento

  Tratamento tratamento = Tratamento(descricao: 'Aplicação de vacina');

  print('\n========== VETERINÁRIO ==========');

  veterinario.atender(cachorro, tratamento);

  //Polimorfismo

  print('\n========== POLIMORFISMO ==========');

  Animal animal1 = cachorro;
  Animal animal2 = gato;

  animal1.fazerSom();
  animal2.fazerSom();
}
