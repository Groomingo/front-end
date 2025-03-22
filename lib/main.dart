import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';
import 'package:provider/provider.dart';
import 'package:groomingo/routes/routes.dart';

import 'package:groomingo/viewmodels/signin_viewmodel.dart';
import 'package:groomingo/styles/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Hide status bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
  await dotenv.load(fileName: ".env");

  KakaoSdk.init(nativeAppKey: dotenv.get("KAKAO_NATIVE_APP_KEY"));

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
