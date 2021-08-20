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
    required Map<String, dynamic> query,
    String lang = 'ar',
    String? token,
  }) async {
    dio!.options.headers = {'lang': lang, 'Authorization': token};
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> post({
    required url,
    required Map<String, dynamic> data,
    String lang = 'ar',
    String token = '',
  }) async {
    dio!.options.headers = {'lang': lang, 'Authorization': token};
    return dio!.post(url, data: data);
  }
}
