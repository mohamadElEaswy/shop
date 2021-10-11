import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> get({
    required String url,
    // Map<String, dynamic>? query,
    String lang = 'en',
    String? token = '',
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio!.get(url
        // , queryParameters: query
    );
  }

  static Future<Response> post({
    required String url,
    required Map<String, dynamic> data,
    String lang = 'en',
    String token = '',
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return dio!.post(url, data: data);
  }

  static Future<Response> put({
    required String url,
    required Map<String, dynamic> data,
    String lang = 'en',
    required String token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return dio!.put(url, data: data);
  }
}
