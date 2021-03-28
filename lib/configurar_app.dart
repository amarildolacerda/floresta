import 'package:flutter/material.dart';

import 'config/config.dart';
//import 'package:controls_web/controls.dart';
//import 'package:controls_extensions/extensions.dart';

configurar() {
  Config.resources
    ..appTitle = 'Storeware Template - App Console'
    ..contaDemo = {"conta": 'm5', "usuario": 'm5', "senha": 'm5'}
    ..primarySwatchColor = Colors.indigo
    ..loginBackgroundWidget = Container(
      width: double.infinity,
      height: double.infinity,
      //color: pastelColors[0].lighten(70),
      child: Opacity(
        child: Image.asset('assets/fundo_login.jpg', fit: BoxFit.cover),
        opacity: 0.2,
      ),
    )
    ..fontFamily = 'Inter';
}
