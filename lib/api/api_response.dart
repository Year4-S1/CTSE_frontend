import 'dart:convert';
import 'package:http/http.dart';
import 'api_status.dart';

class ApiResponse {
  Response? response;
  ApiStatus apiStatus = ApiStatus.UNKNOWN;
  bool isSuccess = false;
  late String statusMessage;
  dynamic jsonBody;
  dynamic extra;

  ApiResponse({this.response, bool validateToken = true}) {
    if (validateToken) {
      if (response != null &&
          response!.statusCode != null &&
          response!.statusCode == 401) {
        isSuccess = false;
        _setErrorMessage("Token expired");
        apiStatus = ApiStatus.CLIENT_ERROR;
        return;
      }
    }
    if (response != null) {
      _processResponse();
    }
  }

  void _setApiStatus(ApiStatus status) {
    apiStatus = status;
    if (status == ApiStatus.SUCCESS) {
      isSuccess = true;
    } else {
      isSuccess = false;
    }
  }

  void _processResponse() {
    try {
      if (response != null) {
        if (!(response!.statusCode == 200 ||
            response!.statusCode == 201 ||
            response!.statusCode == 202)) {
          if (response!.statusCode >= 400 && response!.statusCode <= 499) {
            _setApiStatus(ApiStatus.CLIENT_ERROR);
            try {
              jsonBody = json.decode(response!.body).cast<String, dynamic>();
            } catch (e) {
              print(e);
            }
          } else if (response!.statusCode >= 500 &&
              response!.statusCode <= 599) {
            _setApiStatus(ApiStatus.SERVICE_ERROR);
          } else {
            _setApiStatus(ApiStatus.UNKNOWN);
          }
          _setErrorMessage(response!.reasonPhrase.toString());
        } else {
          jsonBody = _getJsonBody();
          // if (jsonBody != null) {
          _setApiStatus(ApiStatus.SUCCESS);
          // } else {
          //   _setApiStatus(ApiStatus.PARSE_ERROR);
          //   _setErrorMessage("Null json response");
          // }
        }
      } else {
        _setApiStatus(ApiStatus.PARSE_ERROR);
        _setErrorMessage("Null response");
      }
    } catch (e) {
      _setApiStatus(ApiStatus.EXCEPTION);
      _setErrorMessage(e.toString());
    }
  }

  dynamic _getJsonBody() {
    try {
      if (response!.body != null) {
        print('JsonBody --- here');

        return json.decode(response!.body);
      } else {
        _setApiStatus(ApiStatus.PARSE_ERROR);
        _setErrorMessage("Null response body");
      }
    } catch (e) {
      print(e);
      _setApiStatus(ApiStatus.EXCEPTION);
      _setErrorMessage("JSON Parse Error: " + e.toString());
    }
  }

  void _setErrorMessage(String message) {
    print(message);
    this.statusMessage = message;
  }

  int getHttpStatusCode() {
    try {
      return response!.statusCode;
    } catch (e) {
      print(e);
      return -1;
    }
  }
}
