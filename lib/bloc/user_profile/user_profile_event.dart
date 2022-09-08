part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadUserProfileEvent extends UserProfileEvent {
  const LoadUserProfileEvent();
}

class SaveUserProfileEvent extends UserProfileEvent {
  const SaveUserProfileEvent({required this.userProfile});

  final UserProfile userProfile;

  @override
  List<Object> get props => [userProfile];
}
