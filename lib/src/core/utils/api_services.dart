import 'package:dio/dio.dart';

class ApiService {
  static final Dio api = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:3000',
    ),
  );
}
