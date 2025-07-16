import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lafyuu/services/storage/token_storage_service.dart';

class ApiClient {
  static const String _baseUrl = 'http://10.0.2.2:3000';
  final TokenStorageService _tokenStorageService = TokenStorageService();

  Future<Map<String, String>> _getHeaders() async {
    final token = await _tokenStorageService.getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    final headers = await _getHeaders();
    return http.get(url, headers: headers);
  }

  Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    final headers = await _getHeaders();
    return http.post(url, headers: headers, body: jsonEncode(body ?? {}));
  }

  Future<http.Response> postWithoutAuth(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    final headers = {'Content-Type': 'application/json'};
    return http.post(url, headers: headers, body: jsonEncode(body));
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    final headers = await _getHeaders();
    return http.put(url, headers: headers, body: jsonEncode(body));
  }

  Future<http.Response> delete(String endpoint) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    final token = await _tokenStorageService.getToken();
    final headers = {if (token != null) 'Authorization': 'Bearer $token'};
    return http.delete(url, headers: headers);
  }

  Future<http.Response> patch(
    String endpoint, {
    required Map<String, dynamic> body,
  }) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    final headers = await _getHeaders();
    return http.patch(url, headers: headers, body: jsonEncode(body));
  }
}
