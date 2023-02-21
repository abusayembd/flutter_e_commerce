import 'package:e_commerce/core/constaints/my_colors.dart';
import 'package:e_commerce/providers/auth_provider.dart';
import 'package:e_commerce/router/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.goNamed(RouteNames.mainPage);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(top: 16.r, left: 24.r, right: 24.r),
            child: Column(
              children: [
                const _AppBarSection(),
                const _LogoSection(),
                _LoginSignupFormSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBarSection extends StatelessWidget {
  const _AppBarSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Hello Wellcome",
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(
                  height: 21.h,
                  width: 14.h,
                  child: Image.asset("assets/graphics/common/wave.png"),
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              "Let's Login or Signup",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            )
          ],
        ),
        const CircleAvatar(
          backgroundImage: AssetImage("assets/graphics/common/avater.png"),
        )
      ],
    );
  }
}

class _LogoSection extends StatelessWidget {
  const _LogoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 33.r),
      child: Center(
        child: Image.asset(
          "assets/graphics/common/logo.png",
          width: 177.w,
          height: 177.h,
        ),
      ),
    );
  }
}

class _LoginSignupFormSection extends StatelessWidget {
  _LoginSignupFormSection({
    super.key,
  });
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
        ),
        TextField(
          controller: _usernameTextController,
          decoration: InputDecoration(
            hintText: "example: name@email.com",
            hintStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
            fillColor: MyColors.inputBackground,
            filled: true,
            contentPadding:
                EdgeInsets.symmetric(vertical: 26.r, horizontal: 18.r),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
            ),
            focusedBorder: OutlineInputBorder(
              gapPadding: 0.0,
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
            ),
          ),
        ),
        SizedBox(
          height: 11.h,
        ),
        Text(
          "Password",
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
        ),
        TextField(
          controller: _passwordTextController,
          obscureText: _obscureText,
          decoration: InputDecoration(
            hintText: "Your Password",
            hintStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
            fillColor: MyColors.inputBackground,
            filled: true,
            contentPadding:
                EdgeInsets.symmetric(vertical: 26.r, horizontal: 18.r),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
            ),
            focusedBorder: OutlineInputBorder(
              gapPadding: 0.0,
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                //to do: implement state changes
                // setState(() {
                //   _obscureText = !_obscureText;
                // });
              },
              child: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: const Color(0xff555957),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 26.h,
        ),
        Consumer<AuthProvider>(
          builder: (context, authProvider, _) => authProvider.hasError
              ? Center(
                  child: Text(
                    "${authProvider.errorMessage}",
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : Container(),
        ),
        SizedBox(
          height: 26.h,
        ),
        SizedBox(
          width: double.infinity,
          height: 56.h,
          child: ElevatedButton(
            onPressed: () async {
              String username = _usernameTextController.text;
              String password = _passwordTextController.text;
              bool isLoginSucceed =
                  await Provider.of<AuthProvider>(context, listen: false)
                      .login(username, password);
              if (isLoginSucceed) {
                context.goNamed(RouteNames.mainPage);
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: MyColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.r),
              ),
            ),
            child: Consumer<AuthProvider>(
              builder: (context, authProvider, _) => authProvider.isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
            ),
          ),
        ),
        SizedBox(
          height: 14.h,
        ),
        SizedBox(
          width: double.infinity,
          height: 56.h,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: MyColors.secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.r),
              ),
            ),
            child: Text(
              "Signup",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
