import 'package:rxdart/rxdart.dart';
import 'package:user_profile_test/data/repositories/i_user_profile_repository.dart';
import 'package:user_profile_test/domain/entities/user_profile.dart';

class UserProfileRepository implements IUserProfileRepository {
  /// Some fake data source, e.g. it might be from network,
  /// from local database, etc.
  final BehaviorSubject<UserProfile> _userProfileDataSource;

  UserProfileRepository({
    BehaviorSubject<UserProfile>? userProfileDataSource,
  }) : _userProfileDataSource = userProfileDataSource ??
            BehaviorSubject<UserProfile>.seeded(
              UserProfile.byDefault(),
            );

  @override
  Stream<UserProfile> loadUserProfile() => _userProfileDataSource;

  @override
  Stream<UserProfile> saveUserProfile({required UserProfile userProfile}) {
    _userProfileDataSource.add(userProfile);
    return loadUserProfile();
  }
}
