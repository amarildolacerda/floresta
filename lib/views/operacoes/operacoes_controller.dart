// @dart=2.12
import 'package:flutter/material.dart';
import '../../models/propriedade_model.dart';
import 'package:controls_web/drivers.dart';

const pageSelecao = 0;
const pageDigitacao = 1;

final BlocModel<int> pageChanged = BlocModel<int>();

class DefaultOperacoesController extends InheritedWidget {
  final PropriedadesItem propriedade = PropriedadesItem();
  DefaultOperacoesController({Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static DefaultOperacoesController? of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<DefaultOperacoesController>();
  setPropriedade(Map<String, dynamic> dados) => this.propriedade.fromMap(dados);
  goPage(int index) {
    pageChanged.notify(index);
  }
}
