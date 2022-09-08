import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_profile_test/data/repositories/i_user_profile_repository.dart';
import 'package:user_profile_test/domain/entities/user_profile.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final IUserProfileRepository userProfileRepository;

  UserProfileBloc({required this.userProfileRepository})
      : super(const UserProfileInitialState()) {
    on<LoadUserProfileEvent>((event, emit) async {
      emit(const UserProfileLoadingState());

      await emit.forEach(
        userProfileRepository.loadUserProfile(),
        onData: (userProfile) =>
            UserProfileLoadedState(userProfile: userProfile),
        onError: (_, __) => const UserProfileErrorState(),
      );
    });
    on<SaveUserProfileEvent>(
      (event, emit) async {
        emit(const UserProfileLoadingState());

        userProfileRepository.saveUserProfile(userProfile: event.userProfile);

        add(const LoadUserProfileEvent());
      },
    );
  }
}
