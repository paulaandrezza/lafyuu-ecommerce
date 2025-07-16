import 'package:lafyuu/models/user/user.dart';
import 'package:lafyuu/services/auth/auth_service.dart';
import 'package:lafyuu/services/storage/token_storage_service.dart';

class AuthManager {
  final AuthService _authService = AuthService();
  final TokenStorageService _tokenStorageService = TokenStorageService();

  Future<User> signIn(String email, String password) async {
    try {
      final token = await _authService.signIn(email, password);

      final user = _authService.parseToken(token!);

      if (user == null) {
        throw Exception('Invalid token received.');
      }

      await _tokenStorageService.saveToken(token);

      return user;
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future signUp(
    String fullName,
    String username,
    String email,
    String password,
    DateTime birthDate,
    String phoneNumber,
    String gender,
  ) async {
    try {
      await _authService.signUp(
        fullName,
        username,
        email,
        password,
        birthDate,
        phoneNumber,
        gender,
      );

      return null;
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future logout() async {
    try {
      await _tokenStorageService.clearToken();
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  Future<User> getCurrentUser() async {
    try {
      final token = await _tokenStorageService.getToken();
      final user = _authService.parseToken(token!);

      if (user == null) {
        throw Exception('Invalid token received.');
      }

      return user;
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}
