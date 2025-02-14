import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


class ApiRepository {
  

  static BaseOptions options = BaseOptions(baseUrl: 'http://localhost:4000');
  static Dio apiClient = Dio(options)
    ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true));
}
