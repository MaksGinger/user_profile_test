import 'package:user_profile_test/domain/entities/user_profile.dart';

abstract class IUserProfileRepository {
  Stream<UserProfile> loadUserProfile();

  Stream<UserProfile> saveUserProfile({required UserProfile userProfile});
}
