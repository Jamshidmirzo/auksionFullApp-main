import 'dart:convert';
import 'package:auksion_app/models/userp.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ProfileHttpService {
  final String apiKey = 'YOUR_API_KEY'; // Replace with your API key

  Future<void> updateProfile(String profileUrl, String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? data1 = sharedPreferences.getString("userData");
    final user1 = UserProfile.fromMap(jsonDecode(data1!));

    Uri url = Uri.parse('https://your-profile-api-url.com/profile.json');
    final response = await http.post(
      url,
      body: jsonEncode({"profileURL": profileUrl, "name": name, "userID": user1.id}),
    );

    if (response.statusCode != 200) {
      print('Failed to update profile: ${response.body}');
      throw Exception('Failed to update profile');
    }
  }

  Future<UserProfile> getProfile(String userId) async {
    Uri url = Uri.parse('https://your-profile-api-url.com/profile/$userId.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
   
      return UserProfile.fromMap(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      // If profile data doesn't exist, return null or throw an exception
      throw Exception('Profile not found');
    } else {
      throw Exception('Failed to get profile');
    }
  }
}
