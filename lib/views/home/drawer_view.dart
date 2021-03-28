// @dart=2.12
import 'package:controls_web/controls/profile_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/config.dart';
import 'package:controls_web/controls.dart';
import 'package:controls_web/themes/themes.dart';
import 'package:controls_data/local_storage.dart';

/// Drawer principal, associação a pagina de entrada do APP
class DrawerView extends StatefulWidget {
  DrawerView({Key? key}) : super(key: key);

  @override
  _DrawerViewState createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  ValueNotifier<Color> corScheme = ValueNotifier<Color>(Colors.blue);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Opções')),
      body: ListView(children: [
        ProfileUser(
          usuario: Usuario.fromJson(Config.instance.usuarioData.toJson()),
          versao: appVersao,
        ),
        DrawerTile(
            title: 'Propriedades',
            onPressed: () {
              /// clicavel
              ///
              Get.toNamed('/propriedades');
            }),
        genColorScheme(),
        Divider(),
        ListTile(
            title: Text('Sair', style: theme.textTheme.bodyText1!),
            onTap: () {
              Config().logout();
              Get.offAllNamed('/');
            }),
      ]),
    );
  }

  genColorScheme() => ValueListenableBuilder(
      valueListenable: corScheme,
      builder: (a, dynamic color, c) => DrawerTile(
          title: 'Esquema de cores',
          trailing: CircleAvatar(
            backgroundColor: color,
            radius: 10,
          ),
          onPressed: () {
            Dialogs.showPage(context,
                width: 350,
                height: 450,
                child: ColorPickerDialog(
                  title: 'Selecione a cor dominante',
                  colors: [
                    ...[
                      Colors.indigo[900],
                      Colors.indigo[500],
                      Colors.indigo[200],
                      Colors.blue[900],
                      Colors.blue[500],
                      Colors.blue[200],
                    ],
                    ...coldColors,
                    ...pastelColors
                  ].where((r) => r != Colors.transparent).toList()
                      as List<Color>?,
                  onChanged: (color) {
                    LocalStorage().setKey('schema_cores', color.toHex());
                    corScheme.value = color;
                    DynamicTheme.of(context)!.setBrightness(Brightness.light);
                  },
                ));
          }));
}
