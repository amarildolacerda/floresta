import 'package:controls_web/controls/clean_ui.dart';
import 'package:controls_web/controls/horizonta_tab_view.dart';
import 'package:controls_web/controls/injects.dart';
import 'package:controls_web/controls/responsive.dart';
import 'package:controls_web/controls/tabview_bottom.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import '../../config/config.dart';
import '../../injects_build.dart';
import 'drawer_view.dart';
import 'home_menu.dart';
import 'package:get/get.dart';
import 'package:controls_extensions/extensions.dart';

class HomeView extends StatefulWidget {
  final Function() onDispose;
  final String title;
  HomeView({Key key, this.title, this.onDispose}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    ResponsiveInfo responsive = ResponsiveInfo(context);
    return InjectBuilder(
        items: generateInjects(context),
        child: responsive.isMobile ? tabMobile(context) : tabDesktop(context));
  }

  @override
  void initState() {
    if (widget.onDispose != null) widget.onDispose();
    super.initState();
  }

  buildLogout() {
    return IconButton(
      icon: Icon(Icons.login),
      onPressed: () {
        Config().logout();
        Get.offAllNamed('/');
      },
    );
  }

  /// Gera a arqvoe para menu no mobile
  tabMobile(ctx) {
    return Scaffold(
        drawer: Drawer(child: DrawerView()),
        body: Builder(
          builder: (a) => TabViewBottom(
            appBar: AppBar(
              title: Text(widget.title),
              elevation: 0,
              actions: [buildLogout()],
            ),
            //color: theme.bottomAppBarColor,
            //tagColor: theme.indicatorColor,5
            //style: TextStyle(fontSize: 11),
            choices: HomeMenu.generate(),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ActionText(
                    //height: 58,
                    borderWidth: 0,
                    label: 'Usuário',
                    style: TextStyle(fontSize: 12),
                    child:
                        Text(Config().nomeVendedor ?? '', style: TextStyle())),
              ),
            ],
            bottomNavigationBar: SizedBox(
              height: 2,
            ),
          ),
        ));
  }

  /// gera a arvove para desktop
  tabDesktop(BuildContext ctx) {
    var theme = Theme.of(ctx);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        actions: [buildLogout()],
      ),
      body: HorizontalTabView(
        sidebarBackgroundColor: theme.primaryColor.lighten(20),
        indicatorColor: theme.primaryColor.lighten(10),
        tabColor: theme.primaryColor.lighten(20),
        iconColor: theme.textTheme.bodyText1.color,
        choices: HomeMenu.generate(),
      ),
    );
  }
}
