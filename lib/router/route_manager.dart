import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/pages/details_page/ui/details_page.dart';
import 'package:e_commerce/pages/home_page.dart';
import 'package:e_commerce/pages/login_page.dart';
import 'package:e_commerce/pages/main_page/ui/main_page.dart';
import 'package:e_commerce/router/middlewares/auth_middleware.dart';
import 'package:go_router/go_router.dart';

class RouteManager {
  static final routeConfig = GoRouter(
    routes: [
      GoRoute(
          name: RouteNames.mainPage,
          path: RouteNames.mainPage,
          builder: (context, state) => const MainPage(),
          redirect: (context, state) => AuthMiddleware.guardWithLogin(),
          routes: [
            GoRoute(
              name: RouteNames.details,
              path: RouteNames.details,
              builder: (context, state) =>
                  DetailsPage(product: state.extra as ProductModel),
            ),
          ]),
      GoRoute(
        name: RouteNames.logIn,
        path: RouteNames.logIn,
        builder: (context, state) => const LoginPage(),
      ),
    ],
  );
}

abstract class RouteNames {
  static String mainPage = "/main";
  static String logIn = "/";
  static String details = "details";
}
