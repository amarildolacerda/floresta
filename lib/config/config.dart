// @dart=2.12
import 'package:console/config/config.dart' as Cc;
import 'package:controls_data/odata_client.dart';

const inLog = false;
const inDev = false;

const homeRoute = '/';

const appVersao = '2020.10.30';

// ignore: non_constant_identifier_names

class Config {
  static final _singleton = Config._create();
  Config._create();
  factory Config() => _singleton;
  var _config = LocalConfig();
  get password => _config.password;
  set password(x) => _config.password = x;
  get usuario => _config.usuario;
  set usuario(x) => _config.usuario = x;
  get conta => _config.conta;
  set conta(x) => _config.conta = x;
  get lembrarSenha => _config.lembrarSenha;
  set lembrarSenha(x) => _config.lembrarSenha = x;
  get logado => _config.logado;
  get loginChanged => _config.loginChanged;

  logout() => _config.logout();
  init() => _config.init();
  static LocalConfig get instance => _singleton._config;
  static Cc.AppResourcesConst get resources => _singleton._config.resources;

  setup({autoLogin: true}) {
    print('inLog: $inLog');
    if (inLog) {
      ODataInst().log((txt) => print(txt));
    }
    return _config.setup(autoLogin: autoLogin);
  }

  firebaseLogin(conta, usuario, password) {
    return _config.firebaseLogin(conta, usuario, password);
  }

  loginSignInByEmail(conta, email) {
    return _config.loginSignInByEmail(conta, email);
  }

  get codigoVendedor => _config.dadosUsuario.vendedor;
  get nomeVendedor => _config.dadosUsuario.nome;
  get dadosUsuario => _config.dadosUsuario;
}

class LocalConfig extends Cc.ConsoleConfig {
  @override
  afterLoaded(dadosLoja, lojaLogin) {
    super.afterLoaded(dadosLoja, lojaLogin);
  }
}
