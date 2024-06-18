import 'package:auksion_app/models/userp.dart';
import 'package:auksion_app/services/http/profilehttpservice.dart';


class ProfileController {
  final ProfileHttpService profileHttpService = ProfileHttpService();

  Future<void> updateProfile(String photoUrl, String name) {
    return profileHttpService.updateProfile(photoUrl, name);
  }

  Future<UserProfile?> getProfile(String userId) async {
    try {
      return await profileHttpService.getProfile(userId);
    } catch (e) {
      print('Error getting profile: $e');
      return null;
    }
  }
}
