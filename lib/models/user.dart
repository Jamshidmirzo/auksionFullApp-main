import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';
@JsonSerializable()
class User {
  String id;
  String email;
  String password;
  String token;
  DateTime expiryDate;
  User(
      {required this.email,
      required this.id,
      required this.expiryDate,
      required this.password,
      required this.token});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        email: map['email'],
        id: map['id'],
        expiryDate: DateTime.parse(map['expiryDate']),
        password: map['password'],
        token: map['token']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'token': token,
      'expiryDate': expiryDate.toString()
    };
  }
  
}
