import 'package:http/http.dart' as http;
import 'api_caller.dart';
import 'api_response.dart';

class ApiCalls {
  static Future<ApiResponse> signUp({
    required String email,
    required String password,
  }) async {
    try {
      var raw = new Map<String, String>();
      raw['email'] = email;
      raw["password"] = password;

      return ApiCaller.postRequest('/api/users/register', data: raw);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      var raw = new Map<String, String>();
      raw['email'] = email;
      raw["password"] = password;

      return ApiCaller.postRequest('/api/users/login', data: raw);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> signOut({
    required String token,
  }) async {
    try {
      Map<String, String> headers = new Map();
      headers['x-access-token'] = token;

      return ApiCaller.postRequest('/api/users/logout', headers: headers);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> updateUser({
    required String token,
    required String id,
    required String password,
  }) async {
    try {
      var raw = new Map<String, String>();
      raw["password"] = password;

      Map<String, String> headers = new Map();
      headers['x-access-token'] = token;

      return ApiCaller.postRequest('/api/users/$id',
          data: raw, headers: headers);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }
}
