import 'package:flutter/material.dart';
import 'package:flutter_olgoo_product/feature/presentation/authentication/screens/login.screen.dart';
import 'package:flutter_olgoo_product/feature/presentation/authentication/screens/otp.screen.dart';
import 'package:flutter_olgoo_product/feature/presentation/authentication/screens/signup.screen.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter routs =
    GoRouter(navigatorKey: navigatorKey, initialLocation: "/login", routes: [
 
 
 
 
  GoRoute(
    path: '/login',
    name: "/login",
    builder: (context, state) => const LoginScreen(),
  ),
    GoRoute(
      path: '/otp',
      name: "/otp",
      builder: (context, state) {
        final String userPhoneNumber = state.extra as String;
        return OtpScreen(
          userPhoneNumber: userPhoneNumber,
        );
      }),
  GoRoute(
    path: '/signup',
    name: "/signup",
    builder: (context, state) => SignupScreen(),
  ),
  
  
]);
