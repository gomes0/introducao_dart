import 'dart:io';
import 'package:consultacep/controllers/endereco-controller.dart';
import 'package:consultacep/models/endereco.dart';
import 'package:consultacep/view/endereco-view.dart';

void main(List<String> args) async {
  final view = EnderecoView();
  view.iniciar();
}
