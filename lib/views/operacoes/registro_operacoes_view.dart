// @dart=2.12
import 'package:flutter/material.dart';

class RegistroOperacoesView extends StatefulWidget {
  late final Map<String, dynamic> propriedade;
  RegistroOperacoesView({Key? key, required this.propriedade})
      : super(key: key);

  @override
  _RegistroOperacoesViewState createState() => _RegistroOperacoesViewState();
}

class _RegistroOperacoesViewState extends State<RegistroOperacoesView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.propriedade['nome']),
    );
  }
}
