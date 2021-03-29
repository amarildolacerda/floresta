// @dart=2.12
import 'package:controls_data/data_model.dart';
import 'package:controls_data/odata_client.dart';
//import 'package:controls_extensions/extensions.dart';

class OperacaoMvtoItem extends DataItem {
  DateTime? data;
  late Map<String, dynamic>? _dummy = {};
  OperacaoMvtoItem();

  OperacaoMvtoItem.fromJson(data) {
    fromMap(data);
  }

  @override
  fromMap(data) {
    id = data['id'];
    this.data = toDate(data['data']);
    _dummy = data;
    return this;
  }

  @override
  toJson() {
    _dummy!['id'] = id;
    _dummy!['data'] = data;
    return _dummy!;
  }
}

class OperacaoMvtoModel extends ODataModelClass<OperacaoMvtoItem> {
  OperacaoMvtoModel() {
    super.collectionName = 'operacao_mvto';
    API = ODataInst();
  }
  // @override
  OperacaoMvtoItem createItem() {
    return OperacaoMvtoItem();
  }
}
