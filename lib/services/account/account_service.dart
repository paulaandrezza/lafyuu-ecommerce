import 'dart:convert';
import 'package:lafyuu/models/user/user_details.dart';
import 'package:lafyuu/services/api/api_client.dart';

class AccountService {
  final ApiClient _apiClient = ApiClient();

  Future<UserDetails> get() async {
    try {
      final response = await _apiClient.get('/users/account');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(response.body);
        return UserDetails.fromJson(jsonMap);
      } else {
        final Map<String, dynamic> errorResponse = jsonDecode(response.body);
        throw Exception(
          'Failed to load user details: ${errorResponse['error']}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> patchField(String field, dynamic value) async {
    try {
      final body = {field: value};
      final response = await _apiClient.patch('/users/account', body: body);

      if (response.statusCode != 204) {
        final Map<String, dynamic> error = jsonDecode(response.body);
        throw Exception('Failed to update $field: ${error['error']}');
      }
    } catch (e) {
      rethrow;
    }
  }

  changePassword({required String oldPassword, required String newPassword}) {}
}
