import 'dart:ui';

import 'package:app/services.dart';
import 'package:comum/services/config_service.dart';
import 'package:controls_web/controls/injects.dart';
import 'package:controls_web/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'injects_build.dart';
import 'theming.dart';
import 'routing.dart';
import 'package:universal_io/io.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/config.dart';
import 'views/home/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid)
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

  /// Config.init - inicializa a estrutura de Config do APP
  Config().init().then((rsp) async {
    /// Service - instancia os servicos que são carregar ao aniciar o APP
    await Services.init();

    /// InjectBuilder -> inject rotinas a serem utilizadas em compartilhamento de aplicações diferentes
    ///  LoginChanged -> é chamado quando o usuario troca o login
    runApp(InjectBuilder(
      child: ChangeNotifierProvider<LoginChanged>.value(
        value: Config().loginChanged,
        child: MyApp(),
      ),
    ));
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    generateInjects(context);
    return SplashScreen(
        backgroundColor: Colors.grey[100],
        delay: 2000,
        splash: Align(
            child: Container(
          child: //colorFiltered(Colors.white),
              backdoorFilter(),
        )),
        home: FutureBuilder<dynamic>(
            future: Config().setup(autoLogin: inDev),
            builder: (context, snapshot) {
              return DynamicTheme(
                onData: (b) {
                  return getTheme(context, brightness: b);
                },
                builder: (_, theme) => GetMaterialApp(
                  localizationsDelegates: [
                    // ... app-specific localization delegate[s] here
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  //onReady: ,
                  onDispose: () => Services().close(),
                  onReady: () => Services().ready(),
                  supportedLocales: [const Locale('pt', 'BR')],

                  debugShowCheckedModeBanner: false,
                  title: Config.resources.appTitle,
                  theme: theme,

                  /// route de entrada
                  initialRoute: homeRoute,

                  /// configurar routes ->  em  routing->staticRoutes...
                  onGenerateRoute: RoutesApp.generateRoute,
                ),
              );
            }));
  }

  backdoorFilter() => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
              child: Opacity(
            opacity: 0.1,
            child: Image(
                image: AssetImage('assets/splash.png'),
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover),
          ))));
}
