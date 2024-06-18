import 'package:json_annotation/json_annotation.dart';

part 'userp.g.dart';

@JsonSerializable()
class UserProfile {
  String id;
  String displayName;
  String email;
  String photoUrl;

  UserProfile({
    required this.id,
    required this.displayName,
    required this.email,
    required this.photoUrl,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] ?? '',
      displayName: map['displayName'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
    };
  }
}
