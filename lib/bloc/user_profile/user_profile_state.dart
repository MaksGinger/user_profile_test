part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitialState extends UserProfileState {
  const UserProfileInitialState();
}

class UserProfileLoadingState extends UserProfileState {
  const UserProfileLoadingState();
}

class UserProfileErrorState extends UserProfileState {
  const UserProfileErrorState();
}

class UserProfileLoadedState extends UserProfileState {
  const UserProfileLoadedState({required this.userProfile});

  final UserProfile userProfile;

  @override
  List<Object> get props => [userProfile];
}
