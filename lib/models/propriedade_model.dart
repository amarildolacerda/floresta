// @dart=2.12
import 'package:controls_data/data_model.dart';
import 'package:controls_data/odata_client.dart';
import '../data/local_v3.dart';
import 'package:uuid/uuid.dart';

class PropriedadesItem extends DataItem {
  bool? inativo;
  String? sigla;
  String? nome;
  String? ender;
  String? cidade;
  String? estado;
  String? cep;
  String? cnpj;
  String? proprietario;
  DateTime? dataRegistro;

  PropriedadesItem({this.inativo});

  PropriedadesItem.fromJson(data) {
    fromMap(data);
  }

  @override
  fromMap(data) {
    id = data['id'];
    inativo = data['inativo'] ?? false;
    sigla = data['sigla'];
    nome = data['nome'];
    ender = data['ender'];
    cidade = data['cidade'];
    estado = data['estado'];
    cep = data['cep'];
    cnpj = data['cnpj'];
    proprietario = data['proprietario'];
    dataRegistro = toDate(data['data_registro']);
    return this;
  }

  @override
  toJson() {
    return {
      'id': id ?? Uuid().v4(),
      'inativo': inativo ?? false,
      "sigla": sigla,
      "nome": nome,
      "ender": ender,
      "cidade": cidade,
      "estado": estado,
      "cep": cep,
      "cnpj": cnpj,
      "proprietario": proprietario,
      "data_registro": dataRegistro ?? toDate(DateTime.now()),
    };
  }
}

class PropriedadesModel extends ODataModelClass<PropriedadesItem> {
  PropriedadesModel() {
    super.collectionName = 'propriedades';
    API = LocalV3();
  }
  // @override
  PropriedadesItem createItem() {
    return PropriedadesItem();
  }
}
