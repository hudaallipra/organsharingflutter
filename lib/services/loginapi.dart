import 'package:dio/dio.dart';


  final Dio _dio = Dio();
  String baseUrl = 'http://192.168.1.51:5000'; // Replace with your base URL
  int loginid=0;

  Future<Response?> performLogin(String username, String password) async {
     String url = '$baseUrl/loginapi'; // Replace with your API endpoint

    try {
      final response = await _dio.post(
        url,
        data: {
          'username': username,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return response;
    } on DioError catch (e) {
      print('Login failed: ${e.response?.data ?? e.message}');
      return e.response;
    }
  }