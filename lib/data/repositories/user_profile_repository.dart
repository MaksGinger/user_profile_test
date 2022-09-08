import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_profile_test/data/repositories/i_user_profile_repository.dart';
import 'package:user_profile_test/domain/entities/user_profile.dart';

class UserProfileRepository implements IUserProfileRepository {
  /// Some fake data source, e.g. it might be from network,
  /// from local database, etc.
  @visibleForTesting
  final BehaviorSubject<UserProfile> userProfileDataSource;

  UserProfileRepository({
    BehaviorSubject<UserProfile>? userProfileDataSource,
  }) : userProfileDataSource = userProfileDataSource ??
            BehaviorSubject<UserProfile>.seeded(
              UserProfile.byDefault(),
            );

  @override
  Stream<UserProfile> loadUserProfile() => userProfileDataSource;

  @override
  void saveUserProfile({required UserProfile userProfile}) {
    userProfileDataSource.add(userProfile);
  }
}
