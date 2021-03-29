import 'package:app/views/cadastros/cadastros_view.dart';
import 'package:app/views/operacoes/operacoes_view.dart';
import 'package:controls_web/controls/tab_choice.dart';
import 'package:flutter/material.dart';
//import 'package:app/views/painel/painel_view.dart';

/// HomeMenu, monta o menu da pagina de entradas do APP
/// incluir os itens de menu da pagina principal (entrada)
class HomeMenu {
  static generate() {
    return [
      TabChoice(
          image: Icon(Icons.workspaces_filled),
          label: 'Operações',
          builder: () => OperacoesView()),
      TabChoice(
          image: Icon(Icons.dashboard),
          label: 'Cadastros',
          builder: () {
            return CadastrosView();
          }),
      /*TabChoice(
          image: Icon(Icons.person),
          label: 'Operação',
          builder: () {
            return Scaffold(body: Text('Área de Operação')); //PedidosView();
          }),*/
    ];
  }
}
