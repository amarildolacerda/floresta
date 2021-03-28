// @dart=2.12
import 'package:app/models/propriedade_model.dart';
import 'package:controls_web/controls/data_viewer.dart';
import 'package:controls_web/controls/data_viewer_helper.dart';
//import 'package:controls_web/controls/paginated_grid.dart';
import 'package:flutter/material.dart';

/// [class]
class PropriedadesView extends StatefulWidget {
  const PropriedadesView({Key? key}) : super(key: key);

  @override
  _PropriedadesViewState createState() => _PropriedadesViewState();
}

class _PropriedadesViewState extends State<PropriedadesView> {
  late DataViewerController controller;
  @override
  void initState() {
    super.initState();
    controller = DataViewerController(
        onValidate: (x) {
          return PropriedadesItem.fromJson(x).toJson();
        },
        future: () => PropriedadesModel().listNoCached(),
        dataSource: PropriedadesModel(),
        keyName: '',
        columns: [
          DataViewerColumn(name: 'id', visible: false, isVirtual: true),
          DataViewerColumn(name: 'sigla', visible: true),
          DataViewerColumn(name: 'nome', visible: true),
          DataViewerColumn(name: 'ender', visible: false),
          DataViewerColumn(name: 'cidade', visible: false),
          DataViewerColumn(name: 'estado', visible: false),
          DataViewerColumn(name: 'cep', visible: false),
          DataViewerColumn(name: 'cnpj', visible: true),
          DataViewerColumn(name: 'proprietario', visible: false),
          DataViewerHelper.dateTimeColumn(
              DataViewerColumn(name: 'data_registro', visible: false),
              mask: 'dd/MMMM/yyyy'),
          DataViewerHelper.simnaoColumn(
              DataViewerColumn(name: 'inativo', visible: true)),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: DataViewer(
        canInsert: true,
        canEdit: true,
        controller: controller,
        beforeShow: (c) {},
      ),
    );
  }
}
