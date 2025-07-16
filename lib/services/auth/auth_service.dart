import 'dart:convert';

import 'package:lafyuu/models/enums/UserRole.dart';
import 'package:lafyuu/models/user/user.dart';
import 'package:lafyuu/services/api/api_client.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  Future<String?> signIn(String email, String password) async {
    try {
      final response = await _apiClient.postWithoutAuth('/users/sign-in', {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse['token'];
      } else {
        final Map<String, dynamic> errorResponse = jsonDecode(response.body);
        throw Exception('SignIn failed: ${errorResponse['error']}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> signUp(
    String fullName,
    String username,
    String email,
    String password,
    DateTime birthDate,
    String phoneNumber,
    String gender,
  ) async {
    try {
      final response = await _apiClient.postWithoutAuth('/users/sign-up', {
        'name': fullName,
        'username': username,
        'email': email,
        'password': password,
        'birthDate':
            '${birthDate.day.toString().padLeft(2, '0')}/${birthDate.month.toString().padLeft(2, '0')}/${birthDate.year}',

        'phoneNumber': phoneNumber,
        'gender': gender.toLowerCase(),
        'role': 'client',
      });

      if (response.statusCode == 204) {
        return null;
      } else {
        final Map<String, dynamic> errorResponse = jsonDecode(response.body);
        throw Exception('SignUp failed: ${errorResponse['error']}');
      }
    } catch (e) {
      rethrow;
    }
  }

  User? parseToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payloadBase64 = parts[1];
      final normalized = base64.normalize(payloadBase64);
      final decoded = utf8.decode(base64.decode(normalized));

      final Map<String, dynamic> payload = json.decode(decoded);

      final String userId = payload['userId'];

      final String roleString = payload['role'];

      final role = UserRole.values.firstWhere(
        (r) => r.name == roleString.toLowerCase(),
        orElse: () => UserRole.client,
      );

      return User(userId: userId, role: role);
    } catch (e) {
      print('Error parsing token: $e');
      return null;
    }
  }
}
