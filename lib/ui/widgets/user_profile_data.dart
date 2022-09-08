import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_profile_test/bloc/user_profile/user_profile_bloc.dart';
import 'package:user_profile_test/ui/widgets/user_profile_column.dart';

class UserProfileData extends StatefulWidget {
  const UserProfileData({super.key});

  @override
  State<UserProfileData> createState() => _UserProfileDataState();
}

class _UserProfileDataState extends State<UserProfileData> {
  @override
  void initState() {
    BlocProvider.of<UserProfileBloc>(context).add(
      const LoadUserProfileEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        if (state is UserProfileLoadingState) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (state is UserProfileErrorState) {
          return const Center(
            child: Text('Error. Something is wrong'),
          );
        }

        if (state is UserProfileLoadedState) {
          return UserProfileColumn(userProfile: state.userProfile);
        }

        return const SizedBox.shrink();
      },
    );
  }
}
