import 'package:controls_web/services/routes.dart';
import 'package:flutter/material.dart';
import './views/home/home_view.dart';

import 'config/config.dart';
import 'logged_view.dart';
import 'views/home/config_propriedades_view.dart';

class RoutesApp {
  static final _singleton = RoutesApp._create();
  RoutesApp._create() {
    staticRoutes();
  }
  factory RoutesApp() => _singleton;
  Routes model = Routes();
  get routes => model.routes;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (_singleton == null) RoutesApp();
    if (settings.name == '') settings = settings.copyWith(name: homeRoute);
    return Routes.generateRoute(settings);
  }

  pushNamed(context, route, {RouteSettings args}) {
    Routes.pushNamed(context, route, args: args);
  }

  pop(context) {
    Routes.pop(context);
  }

  static getRoute(name) => Routes.getRoute(name);

  push(context, MaterialPageRoute object) {
    Routes.push(context, object);
  }

  go(context, object, {RouteSettings args}) {
    Routes.go(context, object, args: args);
  }

  /// criar as rotas padrões
  staticRoutes() {
    model.addAll({
      '/': (context) => LoggedView(
            child: HomeView(title: Config.resources.appTitle),
          ),
      PropriedadesView.route: (context) =>
          LoggedView(child: PropriedadesView()),
    });
  }
}
