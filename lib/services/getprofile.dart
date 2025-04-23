import 'package:dio/dio.dart';
import 'package:organsharing/services/loginapi.dart';



  final Dio _dio = Dio();

  // Base URL for the API


  // Map to store the profile data
  Map<String, dynamic> profileData = {};

  // Method to fetch profile
  Future<void> getProfile(String userId) async { 
    
    try {
      final response = await _dio.get('$baseUrl/userapi/$userId');
      if (response.statusCode == 200) {
        profileData = response.data;
        print('Profile fetched successfully: $profileData');
      } else {
        print('Failed to fetch profile: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching profile: $e');
    }
  
}