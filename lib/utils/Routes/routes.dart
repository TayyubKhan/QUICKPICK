import 'package:flutter/material.dart';
import 'package:mvvm/utils/Routes/routes_name.dart';
import 'package:mvvm/view/Home_Screen.dart';
import 'package:mvvm/view/Login_screenView.dart';
import 'package:mvvm/view/Signup_ScreenView.dart';
import 'package:mvvm/view/splash_view.dart';

class Routes {
  static Route<dynamic> Generate_Routes(RouteSettings settings) {
    switch (settings.name) {
      case Routesname.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      case Routesname.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashView());
      case Routesname.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Home_screen_View());
      case Routesname.signup:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUp_Screen_View());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('You are on the Wrong way'),
            ),
          );
        });
    }
  }
}
