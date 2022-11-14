import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/database/sqlite_adm_connection.dart';
import 'core/ui/todo_list_ui_config.dart';
import 'modules/auth/auth_module.dart';
import 'modules/auth/login/login_controller.dart';
import 'modules/auth/login/login_page.dart';
import 'modules/splash/splash_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sqliteAdmConnection = SqliteAdmConnection();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(sqliteAdmConnection);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(sqliteAdmConnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list Provider',
      initialRoute: '/login',
      theme: TodoListUiConfig.theme,
      routes: {...AuthModule().routers},
      home: SplashPage(),
    );
  }
}
