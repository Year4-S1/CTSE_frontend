import 'package:http/http.dart' as http;
import 'api_caller.dart';
import 'api_response.dart';

class ApiCalls {
  static Future<ApiResponse> signInUp({
    required String email,
    required String password,
  }) async {
    try {
      var raw = <String, String>{};
      raw["email"] = email;
      raw["password"] = password;

      return ApiCaller.postRequest('/user/register', data: raw);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> verifyOtp({
    required String otp,
  }) async {
    try {
      var raw = <String, String>{};
      raw['otp'] = otp;

      return ApiCaller.postRequest('/user/verify', data: raw);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  // static Future<ApiResponse> signOut({
  //   required String token,
  // }) async {
  //   try {
  //     Map<String, String> headers = new Map();
  //     headers['x-access-token'] = token;

  //     return ApiCaller.postRequest('/api/users/logout', headers: headers);
  //   } catch (e) {
  //     ApiResponse response = ApiResponse();
  //     response.isSuccess = false;
  //     response.statusMessage = e.toString();
  //     return response;
  //   }
  // }

  static Future<ApiResponse> updateUser({
    required String token,
    required String id,
    required String password,
  }) async {
    try {
      var raw = <String, dynamic>{};
      raw["password"] = password;

      Map<String, String> headers = {};
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

  static Future<ApiResponse> getCatagories({
    required String token,
  }) async {
    try {
      Map<String, String> headers = {};
      headers['x-access-token'] = token;
      headers["Accept"] = "multipart/form-data";

      return ApiCaller.getRequest('/category/');
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> postCatagories({
    required Map<dynamic, dynamic> catagories,
    required String token,
  }) async {
    try {
      var raw = <String, dynamic>{"token": token, "data": catagories};

      return ApiCaller.postRequest('/category/create', data: raw);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> updateCatagories({
    required Map<dynamic, dynamic> catagories,
    required String token,
  }) async {
    try {
      var raw = <String, dynamic>{};
      raw["data"] = catagories;

      Map<String, String> headers = {};
      headers['x-access-token'] = token;

      return ApiCaller.putRequest('/category/updatecategory/',
          data: raw, headers: headers);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }
}
