import 'dart:io';

import 'package:coding_with_mamun_community/models/api_response.dart';
import 'package:coding_with_mamun_community/models/app_response.dart';
import 'package:dio/dio.dart';

class AppInterceptors extends Interceptor {
  static AppInterceptors? _singleton;

  AppInterceptors._internal();

  factory AppInterceptors() {
    return _singleton ??= AppInterceptors._internal();
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!options.headers.containsKey(HttpHeaders.authorizationHeader)) {
      const fakeToken = "FakeToken";

      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $fakeToken';
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final responseData = mapResponseData(
      requestOptions: response.requestOptions,
      response: response,
    );
    return handler.resolve(responseData);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final errorMessage = getErrorMessage(err.type, err.response?.statusCode);

    final responseData = mapResponseData(
      requestOptions: err.requestOptions,
      response: err.response,
      customMessage: errorMessage,
      isErrorReponse: true,
    );
    return handler.resolve(responseData);
  }

  String getErrorMessage(DioErrorType type, int? statusCode) {
    switch (type) {
      case DioErrorType.connectTimeout:
        return 'Connection Timeout';
      case DioErrorType.sendTimeout:
        return 'Send Timeout';
      case DioErrorType.receiveTimeout:
        return 'Receive Timeout';
      case DioErrorType.response:
        switch (statusCode) {
          case 400:
            return 'Bad Request';
          case 401:
            return 'Unauthorized';
          case 403:
            return 'Forbidden';
          case 404:
            return 'Not Found';
          case 409:
            return 'Conflict';
          case 500:
            return 'Internal Server Error';
          case 502:
            return 'Bad Gateway';
          case 503:
            return 'Service Unavailable';
          case 504:
            return 'Gateway Timeout';
          default:
            return 'Something went wrong';
        }
      case DioErrorType.cancel:
        return 'Request Cancelled';
      case DioErrorType.other:
        return 'Connection Error';
      default:
        return 'Something went wrong';
    }
  }

  Response<dynamic> mapResponseData({
    Response<dynamic>? response,
    required RequestOptions requestOptions,
    String customMessage = '',
    bool isErrorReponse = false,
  }) {
    final bool hasResponseData = response?.data != null;

    Map<String, dynamic>? responseData = response?.data;

    if (hasResponseData) {
      responseData!.addAll({
        'statusCode': response?.statusCode,
        'statusMessage': response?.statusMessage,
      });
    }

    return Response(
      requestOptions: requestOptions,
      data: hasResponseData
          ? responseData
          : AppResponse(
              message: customMessage,
              success: isErrorReponse ? false : true,
              statusCode: response?.statusCode,
              statusMessage: response?.statusMessage,
            ).toJson(
              (value) => null,
            ),
    );
  }
}
