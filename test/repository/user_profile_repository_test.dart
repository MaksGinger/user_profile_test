import 'package:flutter_test/flutter_test.dart';
import 'package:user_profile_test/data/repositories/user_profile_repository.dart';
import 'package:user_profile_test/domain/entities/user_profile.dart';

void main() {
  group('UserProfileRepository', () {
    final userProfileRepository = UserProfileRepository();
    final defaultProfile = UserProfile.byDefault();

    test('data source is not empty', () {
      expect(
        userProfileRepository.userProfileDataSource.value,
        isA<UserProfile>().having(
          (profile) => profile.name,
          'has default name',
          defaultProfile.name,
        ),
      );
    });

    test('loads user profile from data source', () {
      expect(
        userProfileRepository.loadUserProfile(),
        emits(
          allOf(
            [isA<UserProfile>()],
          ),
        ),
      );
    });

    final newProfile = UserProfile(
      name: 'name',
      birthday: DateTime(2000, 9, 7),
      email: 'email',
      subscriptionStatus: SubscriptionStatus.no,
    );

    test('saves new user profile to data source', () {
      userProfileRepository.saveUserProfile(userProfile: newProfile);
      expect(
        userProfileRepository.userProfileDataSource.value,
        isA<UserProfile>().having(
          (profile) => profile.name,
          'is a',
          newProfile.name,
        ),
      );
    });
  });
}
