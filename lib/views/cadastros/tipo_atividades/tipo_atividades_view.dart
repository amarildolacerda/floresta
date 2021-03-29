import 'package:app/models/tipo_atividades_model.dart';
import 'package:controls_web/controls/data_viewer.dart';
import 'package:controls_web/controls/data_viewer_helper.dart';
import 'package:controls_web/controls/paginated_grid.dart';
import 'package:flutter/material.dart';

/// [class]
class TipoAtividadesView extends StatelessWidget {
  const TipoAtividadesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('')),
      body: DataViewer(
        canEdit: true,
        canInsert: true,
        canDelete: true,
        controller: DataViewerController(
            onValidate: (x) {
              return TipoAtividadesItem.fromJson(x).toJson();
            },
            future: () => TipoAtividadesModel().listNoCached(),
            dataSource: TipoAtividadesModel(),
            keyName: 'id',
            columns: [
              DataViewerColumn(
                  name: 'id',
                  isPrimaryKey: true,
                  visible: false,
                  isVirtual: true),
              DataViewerColumn(name: 'nome'),
              DataViewerHelper.simnaoColumn(DataViewerColumn(name: 'inativo'),
                  trueValue: true, falseValue: false)
            ]),
        beforeShow: (ctrl) {
          /// redefine atributos para as colunas
          if (ctrl is PaginatedGridController) {
//            DataViewerHelper.hideColumn(ctrl.findColumn('gid_servidor'));
//            DataViewerHelper.simnaoColumn(ctrl.findColumn('inativo'));
          }
        },
      ),
    );
  }
}
