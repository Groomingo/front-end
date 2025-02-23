import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'package:groomingo/screens/signin_screen.dart';
import 'package:groomingo/screens/home_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SignInScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(),
    ),
  ],
);
