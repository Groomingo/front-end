import 'package:dio/dio.dart';
import 'package:groomingo/core/config/app_config.dart';

class ApiClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
    ),
  );

  Dio get dio => _dio;
}
