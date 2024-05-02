import 'package:agrotech_hackat/models/data_dump_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import "package:get/get.dart";
import '../models/easy_predict_response.dart';
import '../services/dio client/api_client.dart';

class ClientsRepository extends GetxController {
  late Dio _dio;
  late ApiClient _apiClient;

  ClientsRepository() {
    _dio = _getDio();
    _apiClient = ApiClient(_dio);
  }

  Dio _getDio() {
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 60000),
        receiveTimeout: const Duration(milliseconds: 60000),
        headers: {
          // "authorization": "Bearer $token",
        },
      ),
    );
    if (!kReleaseMode) {
      dio.interceptors.addAll([
        PrettyDioLogger(
            requestBody: true,
            requestHeader: true,
            responseBody: false,
            request: false),
      ]);
    }
    return dio;
  }

  // Create User
  Future<DataDumpResponse> fetchDataDump(
      Map<String, dynamic> userDetails) async {
    try {
      final _response = await _apiClient.getDataDump(userDetails);

      return _response;
    } on DioError catch (e) {
      EasyLoading.dismiss();
      if (e.type == DioExceptionType.badResponse) {
        return DataDumpResponse();
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        return DataDumpResponse();
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        return DataDumpResponse();
      }
      if (e.type == DioExceptionType.unknown) {
        return DataDumpResponse();
      }
      return DataDumpResponse();
    }
  }

  Future<EasyPredictResponse> cropRecommendation(
      Map<String, dynamic> userDetails) async {
    try {
      final response = await _apiClient.getEasyPredictData(userDetails);
      return response;
    } on DioError catch (e) {
      EasyLoading.dismiss();
      if (e.type == DioExceptionType.badResponse) {
        return EasyPredictResponse(status: false);
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        return EasyPredictResponse(status: false);
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        return EasyPredictResponse(status: false);
      }
      if (e.type == DioExceptionType.unknown) {
        return EasyPredictResponse(status: false);
      }
      return EasyPredictResponse(status: false);
    }
  }
}
