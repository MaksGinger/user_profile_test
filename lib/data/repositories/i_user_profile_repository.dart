import 'package:user_profile_test/domain/entities/user_profile.dart';

abstract class IUserProfileRepository {
  Stream<UserProfile> loadUserProfile();

  void saveUserProfile({required UserProfile userProfile});
}
