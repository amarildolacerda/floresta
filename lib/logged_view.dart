//import 'dart:async';

import 'package:comum/services/config_service.dart';
import 'package:controls_data/odata_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_io/io.dart';

import 'config/config.dart';
import 'package:console/views/login/login_view.dart';
//import 'views/login/login_view.dart';

class LoggedView extends StatefulWidget {
  final Widget child;
  const LoggedView({Key key, this.child}) : super(key: key);

  @override
  _LoggedViewState createState() => _LoggedViewState();
}

class _LoggedViewState extends State<LoggedView> {
  // StreamSubscription diretivasBloc;
  //var _context;
  @override
  void initState() {
    super.initState();
    /*  diretivasBloc = (DiretivasBloc().stream as Stream).listen((x) {
      diretivas.register(_context);
    });*/
  }

  @override
  void dispose() {
    // diretivasBloc.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //_context = context;
    if (Config().logado) {
      return widget.child;
    }

    return ChangeNotifierProvider<LoginChanged>.value(
        value: Config().loginChanged,
        child: Consumer<LoginChanged>(builder: (a, evt, c) {
          print('Login changed');
          var lg = !inDev;
          if (!lg && (Platform.isWindows || Platform.isLinux)) lg = true;

          if (lg && (!Config().logado)) {
            return LoginPage();
          }

          print('lg -> child');
          if (lg) {
            return widget.child;
          }

          print('logged -> streambuilder');
          return StreamBuilder(
              stream: LoginTokenChanged().stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Align(child: CircularProgressIndicator());

                return Scaffold(
                    backgroundColor: Colors.grey, body: widget.child);
              });
        }));
  }
}
