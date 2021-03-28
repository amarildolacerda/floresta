import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:controls_data/local_storage.dart';

class DesktopUtils {
  static get isDesktop => (UniversalPlatform.isWindows ||
      UniversalPlatform.isLinux ||
      UniversalPlatform.isMacOS);

  static init() async {
    await DesktopUtils().restoreSize();
    return true;
  }

  static final windowsSize = 'windows_size';

  restoreSize() async {
    if (!isDesktop) return;
    await LocalStorage().init();
    var size = LocalStorage().getJson(windowsSize) ?? {};
    if ((size['width'] ?? 0) > 0 && (size['height'] ?? 0) > 0)
      await DesktopWindow.setWindowSize(Size(size['width'], size['height']));
  }

  saveSize() async {
    if (!isDesktop) return;
    Size size = await DesktopWindow.getWindowSize();
    print(size);
    if (size.width > 0 && size.height > 0) {
      await LocalStorage().init();
      LocalStorage()
          .setJson(windowsSize, {'width': size.width, 'height': size.height});
    }
  }
}
