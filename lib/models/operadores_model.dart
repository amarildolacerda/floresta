// @dart=2.12
import 'package:app/data/local_v3.dart';
import 'package:controls_data/data_model.dart';
import 'package:controls_data/odata_client.dart';

class OperadoresItem extends DataItem {
  //bool inativo;
  late Map<String, dynamic>? _dummy = {};
  OperadoresItem();

  OperadoresItem.fromJson(data) {
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

class OperadoresModel extends ODataModelClass<OperadoresItem> {
  OperadoresModel() {
    super.collectionName = 'operadores';
    API = LocalV3();
  }
  // @override
  OperadoresItem createItem() {
    return OperadoresItem();
  }
}
