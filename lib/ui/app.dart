import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_profile_test/bloc/user_profile/user_profile_bloc.dart';
import 'package:user_profile_test/data/repositories/i_user_profile_repository.dart';
import 'package:user_profile_test/data/repositories/user_profile_repository.dart';
import 'package:user_profile_test/ui/widgets/user_profile_data.dart';

class App extends StatelessWidget {
  const App({super.key});

  static const String _title = 'User Profile';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
        ),
        body: RepositoryProvider<IUserProfileRepository>(
          create: (context) => UserProfileRepository(),
          child: BlocProvider(
            create: (context) => UserProfileBloc(
              userProfileRepository:
                  RepositoryProvider.of<IUserProfileRepository>(context),
            ),
            child: const UserProfileData(),
          ),
        ),
      ),
    );
  }
}
