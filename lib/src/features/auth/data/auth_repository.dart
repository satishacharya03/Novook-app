import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import '../../auth/domain/user.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<User> login(String email, String password) async {
    try {
      final response = await _dio.post(ApiConstants.login, data: {
        'email': email,
        'password': password,
      });
      return User.fromJson(response.data['user']);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<User> register(String name, String email, String password) async {
    try {
      final response = await _dio.post(ApiConstants.register, data: {
        'name': name,
        'email': email,
        'password': password,
      });
      return User.fromJson(response.data['user']);
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<User> getCurrentUser() async {
    try {
      final response = await _dio.get(ApiConstants.me);
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.watch(apiClientProvider));
}
