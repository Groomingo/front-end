import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:groomingo/routes/routes.dart';

import 'package:groomingo/viewmodels/signin_viewmodel.dart';
import 'package:groomingo/styles/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Hide status bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignInViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter, // 라우터 설정
      theme: ThemeData(),
    );
  }
}
