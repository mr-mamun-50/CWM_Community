import 'package:coding_with_mamun_community/utils/dio_client/app_interceptors.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  static DioClient? _singleton;

  static late Dio _dio;

  DioClient._() {
    _dio = createDioClient();
  }

  factory DioClient() {
    return _singleton ??= DioClient._();
  }

  Dio get dio => _dio;

  Dio createDioClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.42.3:8000/api',
        connectTimeout: 5000,
        receiveTimeout: 3000,
        sendTimeout: 3000,
        headers: {
          Headers.acceptHeader: 'application/json',
          Headers.contentTypeHeader: 'application/json',
        },
      ),
    );
    dio.interceptors.addAll([
      AppInterceptors(),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90,
      )
    ]);
    return dio;
  }
}
