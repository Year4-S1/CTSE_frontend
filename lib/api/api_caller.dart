import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_response.dart';
import 'api_status.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

const baseUrl = "https://ctse-note-app-backend.herokuapp.com";
const timeout = 80;

class ApiCaller {
  static Future<ApiResponse> postRequest(String endpoint,
      {Map<String, dynamic>? data, Map<String, String>? headers}) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Map<String, String> allHeaders = new Map();
        allHeaders["Accept"] = "application/json";
        allHeaders["Content-Type"] = "application/json; charset=UTF-8";
        if (headers != null && headers.length > 0) {
          allHeaders.addAll(headers);
        }
        print("Url: " + baseUrl + endpoint);
        print(data);
        final response = await http
            .post(
              Uri.parse(baseUrl + endpoint),
              headers: allHeaders,
              body: jsonEncode(data),
            )
            .timeout(const Duration(seconds: timeout));

        print(response.statusCode.toString() + "  Response: " + response.body);
        return ApiResponse(response: response, validateToken: false);
      } else {
        ApiResponse response = ApiResponse(response: null);
        response.isSuccess = false;
        response.apiStatus = ApiStatus.NO_INTERNET;
        response.statusMessage = "Internet connection not available";
        return response;
      }
    } catch (e) {
      ApiResponse response = ApiResponse();
      if (e is TimeoutException) {
        response.isSuccess = false;
        response.apiStatus = ApiStatus.TIMEOUT;
        response.statusMessage = e.toString();
      } else {
        response.isSuccess = false;
        response.apiStatus = ApiStatus.EXCEPTION;
        response.statusMessage = e.toString();
      }
      print(response.toString());
      return response;
    }
  }

  static Future<ApiResponse> putRequest(String endpoint,
      {Map<String, dynamic>? data, Map<String, String>? headers}) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Map<String, String> allHeaders = new Map();
        allHeaders["Accept"] = "application/json";
        if (headers != null && headers.length > 0) {
          allHeaders.addAll(headers);
        }
        print("Url: " + baseUrl + endpoint);
        // print(data);

        final response = await http
            .put(
              Uri.parse(baseUrl + endpoint),
              headers: allHeaders,
              body: data,
            )
            .timeout(const Duration(seconds: timeout));

        print(response.statusCode.toString() + "  Response: " + response.body);
        return ApiResponse(response: response, validateToken: false);
      } else {
        ApiResponse response = ApiResponse(response: null);
        response.isSuccess = false;
        response.apiStatus = ApiStatus.NO_INTERNET;
        response.statusMessage = "Internet connection not available";
        return response;
      }
    } catch (e) {
      ApiResponse response = ApiResponse();
      if (e is TimeoutException) {
        response.isSuccess = false;
        response.apiStatus = ApiStatus.TIMEOUT;
        response.statusMessage = e.toString();
      } else {
        response.isSuccess = false;
        response.apiStatus = ApiStatus.EXCEPTION;
        response.statusMessage = e.toString();
      }
      print(response.toString());
      return response;
    }
  }

  static Future<ApiResponse> getRequest(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Map<String, String> allHeaders = new Map();

        if (headers != null && headers.length > 0) {
          allHeaders.addAll(headers);
        }
        print("Url: " + baseUrl + endpoint);
        final response = await http
            .get(Uri.parse(baseUrl + endpoint), headers: headers)
            .timeout(const Duration(seconds: timeout));
        print(response.statusCode.toString() + "  Response: " + response.body);

        return ApiResponse(response: response, validateToken: false);
      } else {
        ApiResponse response = ApiResponse();
        response.isSuccess = false;
        response.apiStatus = ApiStatus.NO_INTERNET;
        response.statusMessage = "Internet connection not available";
        return response;
      }
    } catch (e) {
      ApiResponse response = ApiResponse();
      if (e is TimeoutException) {
        response.isSuccess = false;
        response.apiStatus = ApiStatus.TIMEOUT;
        response.statusMessage = e.toString();
      } else {
        response.isSuccess = false;
        response.apiStatus = ApiStatus.EXCEPTION;
        response.statusMessage = e.toString();
      }
      return response;
    }
  }

  static Future<ApiResponse> deleteRequest(String endpoint,
      {Map<String, dynamic>? data, Map<String, String>? headers}) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        Map<String, String> allHeaders = new Map();
        allHeaders["Accept"] = "application/json";
        if (headers != null && headers.length > 0) {
          allHeaders.addAll(headers);
        }
        print("Url: " + baseUrl + endpoint);
        final response = await http
            .delete(Uri.parse(baseUrl + endpoint), headers: headers)
            .timeout(const Duration(seconds: timeout));
        print("Response: " +
            response.body +
            " Code: " +
            response.statusCode.toString());
        return ApiResponse(response: response, validateToken: false);
      } else {
        ApiResponse response = ApiResponse();
        response.isSuccess = false;
        response.apiStatus = ApiStatus.NO_INTERNET;
        response.statusMessage = "Internet connection not available";
        return response;
      }
    } catch (e) {
      ApiResponse response = ApiResponse();
      if (e is TimeoutException) {
        response.isSuccess = false;
        response.apiStatus = ApiStatus.TIMEOUT;
        response.statusMessage = e.toString();
      } else {
        response.isSuccess = false;
        response.apiStatus = ApiStatus.EXCEPTION;
        response.statusMessage = e.toString();
      }
      return response;
    }
  }
}
