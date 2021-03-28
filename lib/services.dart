import 'package:get/get.dart';

import 'configurar_app.dart';
import 'desktop_utils.dart';

/// Services - carrergar os serviços  que precisam ser iniciados quando
///            carrega o APP
class Services extends GetxService {
  static init() async {
    /// codigo de inicialização
    configurar();
  }

  @override
  onInit() {
    super.onInit();
  }

  @override
  onClose() {
    super.onClose();
  }

  close() {
    DesktopUtils().saveSize();
  }

  ready() {
    DesktopUtils.init();
  }
}
