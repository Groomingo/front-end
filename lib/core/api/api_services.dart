import 'package:dio/dio.dart';
import 'package:groomingo/core/api/api_client.dart';

class ApiService {
  final ApiClient _apiClient = ApiClient();

  Future<String> signIn(String email, String password) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/log-in',
        data: {
          'email': email,
          'password': password,
        },
      );
      print('response: ${response.data}, email: $email, password: $password');
      return response.data as String;
    } catch (e) {
      rethrow;
    }
  }
}
