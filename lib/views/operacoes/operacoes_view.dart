// @dart=2.12
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:controls_web/controls.dart';

import 'grid_selecao_propriedades_view.dart';
import 'operacoes_controller.dart';
import 'operacoes_mvto_view.dart';

class OperacoesView extends StatefulWidget {
  const OperacoesView({Key? key}) : super(key: key);

  @override
  _OperacoesViewState createState() => _OperacoesViewState();
}

class _OperacoesViewState extends State<OperacoesView> {
  late StreamSubscription pageNotifier;
  VerticalTopTabNavigatorController controller =
      VerticalTopTabNavigatorController();
  @override
  void initState() {
    super.initState();
    pageNotifier = pageChanged.listen((index) {
      controller.animateTo(index);
    });
  }

  @override
  void dispose() {
    pageNotifier.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultOperacoesController(
        child: VerticalTopTabView(controller: controller, choices: [
      TabChoice(
        label: 'Propriedade',
        builder: () => GridSelecaoPropriedadeView(),
      ),
      TabChoice(
        label: 'Movimento',
        builder: () => OperacoesMvtoView(),
      )
    ]));
  }
}
