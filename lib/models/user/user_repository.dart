import 'package:groomingo/core/api/api_services.dart';

class UserRepository {
  final ApiService _apiService = ApiService();

  Future<String> signIn(String email, String password) async {
    final accessToken = await _apiService.signIn(email, password);
    return accessToken;
  }
}
