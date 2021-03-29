// @dart=2.12
import 'package:app/data/local_v3.dart';
import 'package:controls_data/data_model.dart';
import 'package:controls_data/odata_client.dart';

class TipoAtividadesItem extends DataItem {
  bool? inativo = false;

  late Map<String, dynamic>? _dummy = {};
  TipoAtividadesItem();

  TipoAtividadesItem.fromJson(data) {
    fromMap(data);
  }

  @override
  fromMap(data) {
    id = data['id'];
    _dummy = data;
    return this;
  }

  @override
  toJson() {
    _dummy!['id'] = id;
    return _dummy!;
  }
}

class TipoAtividadesModel extends ODataModelClass<TipoAtividadesItem> {
  TipoAtividadesModel() {
    super.collectionName = 'tipo_atividades';
    API = LocalV3();
  }
  // @override
  TipoAtividadesItem createItem() {
    return TipoAtividadesItem();
  }
}
