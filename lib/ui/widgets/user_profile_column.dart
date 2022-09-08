import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_profile_test/bloc/user_profile/user_profile_bloc.dart';
import 'package:user_profile_test/domain/entities/user_profile.dart';
import 'package:user_profile_test/utils/date_time_ext.dart';

class UserProfileColumn extends StatelessWidget {
  const UserProfileColumn({
    Key? key,
    required this.userProfile,
  }) : super(key: key);

  final UserProfile userProfile;

  final _divider = const Divider();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: screenSize.height * 0.1,
          ),
          CircleAvatar(
            radius: screenSize.width * 0.25,
            foregroundImage: NetworkImage(
              userProfile.profilePictureUrl,
            ),
          ),
          const SizedBox(height: 20),
          _ProfileInfoTile(
            title: userProfile.name,
            icon: Icons.person,
          ),
          _divider,
          _ProfileInfoTile(
            title: userProfile.email,
            icon: Icons.email,
          ),
          _divider,
          _ProfileInfoTile(
            title: userProfile.birthday.format(),
            icon: Icons.calendar_month,
          ),
          _divider,
          _ProfileInfoTile(
            title: userProfile.subscriptionStatus.name,
            icon: Icons.monetization_on,
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            child: const Text('Edit Profile Data'),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return BlocProvider<UserProfileBloc>.value(
                      value: BlocProvider.of<UserProfileBloc>(context),
                      child: _FormAlertDialog(
                        userProfile: userProfile,
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}

class _FormAlertDialog extends StatefulWidget {
  const _FormAlertDialog({
    Key? key,
    required this.userProfile,
  }) : super(key: key);

  final UserProfile userProfile;

  @override
  State<_FormAlertDialog> createState() => _FormAlertDialogState();
}

class _FormAlertDialogState extends State<_FormAlertDialog> {
  late final TextEditingController _imageController =
      TextEditingController(text: widget.userProfile.profilePictureUrl);
  late final TextEditingController _nameController =
      TextEditingController(text: widget.userProfile.name);
  late final TextEditingController _emailController =
      TextEditingController(text: widget.userProfile.email);
  late DateTime _date = widget.userProfile.birthday;
  late SubscriptionStatus _subscriptionStatus =
      widget.userProfile.subscriptionStatus;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Profile Data'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _FormTextField(
            controller: _imageController,
            hintText: 'Enter your profile image url',
            labelText: 'Profile Image URL',
            icon: Icons.image,
          ),
          _FormTextField(
            controller: _nameController,
            hintText: 'Enter your name',
            labelText: 'Name',
            icon: Icons.person,
          ),
          _FormTextField(
            controller: _emailController,
            hintText: 'Enter your email',
            labelText: 'Email',
            icon: Icons.email,
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text('Choose your date of birth:'),
          ),
          const Divider(),
          SizedBox(
            height: 100,
            child: CupertinoTheme(
              data: const CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _date,
                onDateTimeChanged: (newDate) {
                  setState(() => _date = newDate);
                },
              ),
            ),
          ),
          const Divider(),
          const Center(
            child: Text('Choose your subscription status:'),
          ),
          ListTile(
            title: Text(SubscriptionStatus.yes.name),
            leading: Radio<SubscriptionStatus>(
              value: SubscriptionStatus.yes,
              groupValue: _subscriptionStatus,
              onChanged: (status) {
                if (status != null) {
                  setState(() => _subscriptionStatus = status);
                }
              },
            ),
          ),
          ListTile(
            title: Text(SubscriptionStatus.no.name),
            leading: Radio<SubscriptionStatus>(
              value: SubscriptionStatus.no,
              groupValue: _subscriptionStatus,
              onChanged: (status) {
                if (status != null) {
                  setState(() => _subscriptionStatus = status);
                }
              },
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_imageController.text.isNotEmpty &&
                _nameController.text.isNotEmpty &&
                _emailController.text.isNotEmpty) {
              final userProfile = UserProfile(
                name: _nameController.text,
                email: _emailController.text,
                birthday: _date,
                subscriptionStatus: _subscriptionStatus,
                profilePictureUrl: _imageController.text,
              );
              BlocProvider.of<UserProfileBloc>(context)
                  .add(SaveUserProfileEvent(userProfile: userProfile));
              Navigator.of(context).pop();
            }
          },
          child: const Text('Confirm'),
        )
      ],
    );
  }
}

class _FormTextField extends StatelessWidget {
  const _FormTextField({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.icon,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        icon: Icon(icon),
        hintText: hintText,
        labelText: labelText,
      ),
    );
  }
}

class _ProfileInfoTile extends StatelessWidget {
  const _ProfileInfoTile({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
      ),
    );
  }
}
