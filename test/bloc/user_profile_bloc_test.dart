import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_profile_test/bloc/user_profile/user_profile_bloc.dart';
import 'package:user_profile_test/data/repositories/i_user_profile_repository.dart';
import 'package:user_profile_test/domain/entities/user_profile.dart';

class MockUserProfileRepo extends Mock implements IUserProfileRepository {}

void main() {
  group('UserProfileBloc', () {
    final defaultProfile = UserProfile.byDefault();
    late IUserProfileRepository profileRepo;
    late UserProfileBloc bloc;

    setUp(() {
      profileRepo = MockUserProfileRepo();
      bloc = UserProfileBloc(userProfileRepository: profileRepo);

      when(
        () => profileRepo.loadUserProfile(),
      ).thenAnswer(
        (invocation) => Stream<UserProfile>.value(defaultProfile),
      );
    });

    test('initial state of bloc is UserProfileInitialState', () {
      expect(bloc.state, isA<UserProfileInitialState>());
    });

    blocTest(
      'when LoadUserProfileEvent, LoadedState emits',
      act: (bloc) => bloc.add(const LoadUserProfileEvent()),
      build: () => bloc,
      expect: () => <TypeMatcher<UserProfileState>>[
        isA<UserProfileLoadingState>(),
        isA<UserProfileLoadedState>().having(
          (st) => st.userProfile,
          'is a default',
          defaultProfile,
        )
      ],
    );

    blocTest(
      'when LoadUserProfileEvent, ErrorState emits',
      act: (bloc) => bloc.add(const LoadUserProfileEvent()),
      setUp: () {
        when(
          () => profileRepo.loadUserProfile(),
        ).thenAnswer(
          (invocation) => Stream<UserProfile>.error(Error()),
        );
      },
      build: () => bloc,
      expect: () => <TypeMatcher<UserProfileState>>[
        isA<UserProfileLoadingState>(),
        isA<UserProfileErrorState>(),
      ],
    );

    final newProfile = defaultProfile.copyWith(name: 'name');

    blocTest(
      'when SaveUserProfileEvent, Error state emits',
      act: (bloc) {
        bloc.add(SaveUserProfileEvent(userProfile: newProfile));
      },
      setUp: () {
        when(
          () => profileRepo.loadUserProfile(),
        ).thenAnswer(
          (invocation) => Stream<UserProfile>.error(Error()),
        );
      },
      build: () => bloc,
      expect: () => <TypeMatcher<UserProfileState>>[
        isA<UserProfileLoadingState>(),
        isA<UserProfileErrorState>(),
      ],
    );
  });
}
