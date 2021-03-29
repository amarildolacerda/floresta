// @dart=2.12
import 'package:app/models/operacao_model.dart';
import 'package:app/models/propriedade_model.dart';
import 'package:flutter/material.dart';
import 'package:controls_web/controls.dart';

import 'operacoes_controller.dart';

class GridSelecaoPropriedadeView extends StatefulWidget {
  const GridSelecaoPropriedadeView({Key? key}) : super(key: key);

  @override
  _GridSelecaoPropriedadeViewState createState() =>
      _GridSelecaoPropriedadeViewState();
}

class _GridSelecaoPropriedadeViewState
    extends State<GridSelecaoPropriedadeView> {
  late CardGridController? controller;
  @override
  void initState() {
    super.initState();
    controller = CardGridController();
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return CardGrid(
        onChangeEvent: (a, b, c) async {
          return {};
        },
        controller: controller,
        futureSource: PropriedadesModel().listNoCached(),
        columns: [CardGridColumn(name: 'nome')],
        builder: (dados) {
          return Card(
              child: Container(
            color: genColor(index++),
            child: ListTile(
              title: Text(dados['nome']),
              onTap: () {
                final DefaultOperacoesController p =
                    DefaultOperacoesController.of(context)!;
                p.setPropriedade(dados);
                p.goPage(pageDigitacao);
              },
            ),
          ));
        });
  }
}
