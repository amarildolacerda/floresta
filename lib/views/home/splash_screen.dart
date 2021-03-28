// @dart=2.12
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

class SplashScreen extends StatefulWidget {
  final Widget splash;
  final Widget home;
  final int delay;
  final Color backgroundColor;
  const SplashScreen(
      {Key? key,
      required this.home,
      required this.splash,
      this.delay = 1500,
      required this.backgroundColor})
      : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  ValueNotifier<int> timeOut = ValueNotifier<int>(0);
  bool get canSplash => (UniversalPlatform.isMacOS ||
      UniversalPlatform.isLinux ||
      UniversalPlatform.isWindows);
  @override
  Widget build(BuildContext context) {
    if (canSplash)
      Timer(Duration(milliseconds: widget.delay), () {
        timeOut.value = timeOut.value + 1;
      });

    return ValueListenableBuilder(
        valueListenable: timeOut,
        builder: (_, v, __) {
          return (v == 0 && canSplash)
              ? MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: Scaffold(
                      backgroundColor: widget.backgroundColor,
                      body: widget.splash))
              : widget.home;
        });
  }
}
