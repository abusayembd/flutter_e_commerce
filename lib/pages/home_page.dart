import 'package:e_commerce/core/constaints/shared_preference_keys.dart';
import 'package:e_commerce/datasources/toen_datasource.dart';
import 'package:e_commerce/router/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text("Home Page"),
              ),
              ElevatedButton(
                  onPressed: () async {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();

                    TokenDatasource tokenDatasource =
                        TokenDatasource(sharedPreferences);
                    if (await tokenDatasource.delete()) {
                      print("Logged out");
                    } else {
                      print("Logged Out failed");
                    }

                    context.goNamed(RouteNames.logIn);
                  },
                  child: const Text("Log Out"))
            ],
          ),
        ),
      ),
    );
  }
}
