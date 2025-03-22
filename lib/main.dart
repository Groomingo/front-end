import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';
import 'package:provider/provider.dart';
import 'package:groomingo/routes/routes.dart';

import 'package:groomingo/viewmodels/signin_viewmodel.dart';
import 'package:groomingo/styles/colors.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);

    try {
      await dotenv.load(fileName: ".env");
      print('.env 파일 로드 성공');
    } catch (e) {
      print('.env 파일 로드 실패: $e');
    }

    try {
      KakaoSdk.init(nativeAppKey: dotenv.get("KAKAO_NATIVE_APP_KEY"));
      print('카카오 SDK 초기화 성공');
    } catch (e) {
      print('카카오 SDK 초기화 실패: $e');
    }

    // 나머지 코드
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SignInViewModel()),
        ],
        child: const MyApp(),
      ),
    );
  }, (error, stackTrace) {
    print('예상치 못한 오류 발생: $error');
    print(stackTrace);
  });
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
