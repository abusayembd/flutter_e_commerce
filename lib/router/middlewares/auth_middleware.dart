import 'dart:async';

import 'package:e_commerce/core/constaints/shared_preference_keys.dart';
import 'package:e_commerce/datasources/toen_datasource.dart';
import 'package:e_commerce/router/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMiddleware {
  static FutureOr<String> guardWithLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    TokenDatasource tokenDatasource = TokenDatasource(sharedPreferences);

    if ((await tokenDatasource.get()) != null) {
      return RouteNames.homePage;
    }
    return RouteNames.logIn;
  }
}
