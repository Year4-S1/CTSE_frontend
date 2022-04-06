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

  static Future<ApiResponse> forgotPassword({
    required String token,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      var raw = <String, String>{};
      raw['token'] = token;
      raw['oldPassword'] = oldPassword;
      raw['newPassword'] = newPassword;

      return ApiCaller.putRequest('/user/update', data: raw);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getCatagories({
    required String userId,
  }) async {
    try {
      Map<String, String> headers = {};
      headers["Accept"] = "multipart/form-data";

      return ApiCaller.getRequest('/category/$userId');
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> postCatagories({
    required Map<dynamic, dynamic> catagories,
    required String userId,
  }) async {
    try {
      var raw = <String, dynamic>{"id": userId, "data": catagories};

      return ApiCaller.postRequest('/category/create', data: raw);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getNotes({
    required String userId,
  }) async {
    try {
      Map<String, String> headers = {};
      headers["Accept"] = "multipart/form-data";

      return ApiCaller.getRequest('/note/userid/$userId');
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> postNote({
    required String catagoryColor,
    required String userId,
    required String noteTitle,
    required String noteMessage,
  }) async {
    try {
      var raw = <String, dynamic>{
        "userId": userId,
        "categoryColor": catagoryColor,
        "noteTitle": noteTitle,
        "noteMessage": noteMessage,
      };

      return ApiCaller.postRequest('/note/create', data: raw);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> updateNote({
    required String catagoryColor,
    required String noteId,
    required String noteTitle,
    required String noteMessage,
  }) async {
    try {
      var raw = <String, dynamic>{
        "categoryColor": catagoryColor,
        "noteTitle": noteTitle,
        "noteMessage": noteMessage,
      };

      return ApiCaller.putRequest('/note/updatenote/$noteId', data: raw);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> deletNote({
    required String noteId,
  }) async {
    try {
      return ApiCaller.deleteRequest('/note/deletenote/$noteId');
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> getTodos({
    required String userId,
  }) async {
    try {
      Map<String, String> headers = {};
      headers["Accept"] = "multipart/form-data";

      return ApiCaller.getRequest('/reminder/userid/$userId');
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> postTodo({
    required String catagoryColor,
    required String userId,
    required String todoTitle,
    String? todoRemakrs,
    String? reminderDate,
    String? reminderTime,
  }) async {
    try {
      var raw = <String, dynamic>{
        "userId": userId,
        "categoryColor": catagoryColor,
        "reminderTitle": todoTitle,
        "reminderMessage": todoRemakrs,
        "reminderDate": reminderDate,
        "reminderTime": reminderTime
      };

      return ApiCaller.postRequest('/reminder/create', data: raw);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> todoActiveSetter({
    required String todoId,
    required bool active,
  }) async {
    try {
      var raw = <String, dynamic>{
        "activeStatus": active,
      };

      return ApiCaller.putRequest('/reminder/update/active/$todoId', data: raw);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> updateTodo({
    required String userId,
    required String todoId,
    required String todoTitle,
    required String catagoryColor,
    String? todoRemakrs,
    String? reminderDate,
    String? reminderTime,
    bool? activeStatus,
  }) async {
    try {
      var raw = <String, dynamic>{
        "categoryColor": catagoryColor,
        "reminderTitle": todoTitle,
        "reminderMessage": todoRemakrs,
        "reminderDate": reminderDate,
        "reminderTime": reminderTime,
        // "userId": userId,
        // "activeStatus": activeStatus
      };

      return ApiCaller.putRequest('/reminder/update/$todoId', data: raw);
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }

  static Future<ApiResponse> deleteTodo({
    required String todoId,
  }) async {
    try {
      return ApiCaller.deleteRequest('/reminder/delete/$todoId');
    } catch (e) {
      ApiResponse response = ApiResponse();
      response.isSuccess = false;
      response.statusMessage = e.toString();
      return response;
    }
  }
}
