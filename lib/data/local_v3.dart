// @dart=2.12
import 'package:path_provider/path_provider.dart';

import 'package:controls_data/odata_client.dart';
import 'package:sembast/sembast.dart';
import 'sm_io.dart' if (dart.library.js) 'sm_web.dart';
import 'package:path/path.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:controls_data/rest_client.dart';

class LocalV3 extends LocalV3Client {
  static final _singleton = LocalV3._create();
  LocalV3._create({String path = 'storeware.db'}) {
    super.path = path;
    super._init();
  }
  factory LocalV3() => _singleton;

  get instance => super.db;
}

class LocalRestClient extends RestClient {
  LocalRestClient() {
    isLocalApi = true;
  }
}

class LocalV3Client extends ODataClient {
  late String? path;
  late Database? db;
  LocalV3Client([
    this.path,
    this.db,
  ]) {
    if (path != null) _init();
  }
  _init() async {
    if (db == null) {
      late String dir = '';
      if (!UniversalPlatform.isWeb) {
        final appDocumentDir = await getApplicationDocumentsDirectory();
        dir = appDocumentDir.path;
      }
      db = await databaseFactory.openDatabase(join(dir, path));
      client = LocalRestClient();
    }
  }

  get instance => db!;

  Map<String, dynamic> reviverAll(Map<String, dynamic> j) {
    Map<String, dynamic> r = {};
    j.keys.forEach((k) {
      var v = j[k];
      if (v is DateTime)
        r[k] = toDateTimeSql(v);
      else
        r[k] = v;
    });
    return r;
  }

  @override
  Future<String> post(String resource, Map<String, dynamic> json,
      {bool removeNulls = true}) async {
    final d = reviverAll(json);
    final store = stringMapStoreFactory.store(resource);
    //d['key'] = d['id'];
    try {
      String key = await store.add(instance, d);
      json['id'] = key;
      return '{"rows": ${key.isEmpty ? 0 : 1} }';
    } catch (e) {
      print('$e');
      rethrow;
    }
  }

  @override
  Future<String> put(String resource, Map<String, dynamic> json,
      {bool removeNulls = true}) async {
    final d = reviverAll(json);
    final store = stringMapStoreFactory.store(resource);
    final finder = Finder(filter: Filter.byKey(d['id']));
    int key = await store.update(instance, d, finder: finder);
    if (key == 0) return put(resource, d, removeNulls: removeNulls);
    return '{"rows": $key}';
  }

  @override
  Future<dynamic> getOne(String resource, {String? id}) async {
    final store = stringMapStoreFactory.store(resource);
    final record = store.record(id!).getSnapshot(instance)
        as RecordSnapshot<int, Map<String, Object>>;
    dynamic rt = {};
    record.value.entries.forEach((element) {
      rt[element] = record.value[element];
    });
    return rt;
  }

  @override
  Future<dynamic> send(ODataQuery query, {String? cacheControl}) async {
    try {
      final store = stringMapStoreFactory.store(query.resource);
      Finder? finder;
      if (query.filter == null) {
        // nada fazer, pega tudo
      } else if (query.filter is Map && query.filter['id'] != null)
        finder = Finder(filter: Filter.byKey(query.filter['id']));
      else
        finder = createFinder(query.filter);

      List<RecordSnapshot<String, Object?>>? records = [];
      if (finder == null)
        records = await store.find(instance);
      else
        records = await store.find(instance, finder: finder);
      if (records.length == 0) return noop;
      //return records.map((RecordSnapshot snap) {
      var r = {
        "rows": records.length,
        "result": [for (var item in records) _fields(item)]
      };
      return r;
      //});
    } catch (e) {
      //ErrorNotify.send('$e');
      // collection nao existe
      return noop;
    }
  }

  Map<String, dynamic> _fields(RecordSnapshot<String, Object?> tx) {
    var c = tx.value as Map<String, Object?>;
    Map<String, dynamic> r = {};
    c.forEach((key, value) {
      if (value != null) r[key] = value;
    });
    print([tx.key, tx.value]);
    r['id'] = tx.key;
    return r;
  }

  get noop => {"rows": 0, "result": []};

  @override
  Future<String> delete(String resource, Map<String, dynamic> json) async {
    final store = stringMapStoreFactory.store(resource);
    final finder = Finder(filter: Filter.byKey(json['id']));
    int k = await store.delete(instance, finder: finder);
    return '{"rows":1}';
  }

  Finder? createFinder(dynamic? filter) {
    if (filter == null) return null;
    if (filter is String) {
      var split = filter.split(' ');
      late Finder? finder;
      while (split.length > 2) {
        var field = split[0];
        var f = split[1];
        var value = split[2];
        if (f == 'eq') finder = Finder(filter: Filter.equals(field, value));
        if (f == 'ge')
          finder = Finder(filter: Filter.greaterThanOrEquals(field, value));
        if (f == 'gt')
          finder = Finder(filter: Filter.greaterThan(field, value));
        if (f == 'le')
          finder = Finder(filter: Filter.lessThanOrEquals(field, value));

        if (f == 'lt') finder = Finder(filter: Filter.lessThan(field, value));
        if (f == 'ne') finder = Finder(filter: Filter.notEquals(field, value));
        split.removeAt(0);
        split.removeAt(0);
        split.removeAt(0);
        // TODO: como por mais de uma condição
        break;
      }
      return finder;
    }
  }
}
