//import 'package:controls_web/controls/menu_dialogs.dart';
import 'package:controls_web/controls/vertical_toptab_navigator.dart';
import 'package:flutter/material.dart';
//import 'package:pedido/views/pedidos/pedidos_menu.dart';
import 'package:console/views/pedidoVendas/pv_view.dart';

class PedidosView extends StatefulWidget {
  const PedidosView({Key key}) : super(key: key);

  @override
  _PedidosViewState createState() => _PedidosViewState();
}

class _PedidosViewState extends State<PedidosView> {
  VerticalTopTabNavigatorController controller;
  @override
  Widget build(BuildContext context) {
    return PvView();
  }
}
