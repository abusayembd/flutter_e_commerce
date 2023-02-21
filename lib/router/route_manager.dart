import 'package:e_commerce/pages/home_page.dart';
import 'package:e_commerce/pages/login_page.dart';
import 'package:e_commerce/router/middlewares/auth_middleware.dart';
import 'package:go_router/go_router.dart';

class RouteManager {
  static final routeConfig = GoRouter(
    routes: [
      GoRoute(
        name: RouteNames.homePage,
        path: RouteNames.homePage,
        builder: (context, state) => const HomePage(),
        redirect: (context, state) => AuthMiddleware.guardWithLogin(),
      ),
      GoRoute(
        name: RouteNames.logIn,
        path: RouteNames.logIn,
        builder: (context, state) => const LoginPage(),
      ),
    ],
  );
}

abstract class RouteNames {
  static String homePage = "/home";
  static String logIn = "/";
}
