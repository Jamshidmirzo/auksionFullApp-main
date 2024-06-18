import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthHttpService {
  final String _apiKey = 'AIzaSyBGo2qgG6mOWRHDCv32D_VasKZ-rspg6H0';

  Future<Map<String, dynamic>> _authenticate(
      String email, String password, String action) async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$action?key=$_apiKey');
    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final data = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode != 200) {
        throw (data['error']['message']);
      }
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> register(String email, String password) async {
    return await _authenticate(email, password, 'signUp');
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    return await _authenticate(email, password, 'signInWithPassword');
  }

  Future<Map<String, dynamic>> changepass(String email) async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=$_apiKey');
    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            'requestType': 'PASSWORD_RESET',
            'email': email,
          },
        ),
        headers: {'Content-Type': 'application/json'},
      );
      final data = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode != 200) {
        throw (data['error']['message']);
      }
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
