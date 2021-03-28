import 'package:flutter/material.dart';

import 'painel_vendas.dart';

class PainelView extends StatelessWidget {
  static final route = '/painel';
  const PainelView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        PainelVendasPage(),
      ],
    );
  }
}
