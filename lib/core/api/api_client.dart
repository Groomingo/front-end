import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:groomingo/core/config/app_config.dart';

class ApiClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
    ),
  );

  ApiClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final accessToken = prefs.getString('accessToken');

          // 로그인 및 회원가입 요청의 경우 토큰을 추가하지 않음
          if (accessToken != null && !isAuthRequest(options.path)) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
      ),
    );
  }

  bool isAuthRequest(String path) {
    return path == '/auth/log-in' || path == '/auth/sign-up';
  }

  Dio get dio => _dio;
}
