import 'package:chat_app_riverpod/common/widgets/error.dart';
import 'package:chat_app_riverpod/features/auth/screens/login_screen.dart';
import 'package:chat_app_riverpod/features/auth/screens/otp_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OTPScreen(
          verificationId: verificationId,
        ),
      );

    default:
      return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: ErrorScreen(error: 'This page doesn\'t exist!'),
            )),
      );
  }
}
