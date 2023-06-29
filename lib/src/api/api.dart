// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../utils/bot_toast/bot_toast_functions.dart';
import 'exception/api_exception.dart';
import 'exception/auth_exception.dart';
import 'exception/server_exception.dart';

class ApiHelper {
  static const String _baseUrl = 'https://valorant-api.com/v1';

  /// Function to make get request to the [endpoint] with [queryParams].
  static Future<dynamic> get(String endpoint,
      {Map<String, String>? queryParams}) async {
    var responseJson;

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl$endpoint').replace(
          queryParameters: queryParams,
        ),
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  /// Function to return the appropriate response according to the status code.
  static dynamic _returnResponse(dynamic response) async {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 401:
        throw AuthException(code: "unauthorized-access");

      case 400:
        String code = jsonDecode(response.body)['errors'][0];
        // showNotification(title: code);
        throw ApiException(code: code);

      case 422:
        String code = jsonDecode(response.body)['message'];
        showNotification(title: (code));

        throw ApiException(code: code);

      case 500:
        throw ServerException(
            code: "server-error", message: "Internal Server Error");

      default:
        throw ('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
