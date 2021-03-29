import 'package:flutter/material.dart';
import 'package:controls_web/controls.dart';

import 'operadores/operadores_view.dart';
import 'propriedades/propriedades_view.dart';
import 'tipo_atividades/tipo_atividades_view.dart';

class CadastrosView extends StatelessWidget {
  const CadastrosView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: VerticalTopTabView(
        actions: [
          IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () =>
                  MenuDialog.show(context, closeMainDialog: false, choices: [
                    MenuChoice(
                        title: 'Operadores', builder: (_) => OperadoresView()),
                    MenuChoice(
                        title: 'Tipo Atividade',
                        builder: (_) => TipoAtividadesView())
                  ])),
        ],
        choices: [
          TabChoice(label: 'Propriedades', builder: () => PropriedadesView()),
        ],
      ),
    );
  }
}
