import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_profile_test/bloc/user_profile/user_profile_bloc.dart';
import 'package:user_profile_test/domain/entities/user_profile.dart';

class UserProfileForm extends StatefulWidget {
  const UserProfileForm({
    Key? key,
    required this.userProfile,
  }) : super(key: key);

  final UserProfile userProfile;

  @override
  State<UserProfileForm> createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
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
          _SubscriptionStatusRadio(
            subscriptionStatus: _subscriptionStatus,
            radioValue: SubscriptionStatus.yes,
            onChangeStatus: _changeStatus,
          ),
          _SubscriptionStatusRadio(
            subscriptionStatus: _subscriptionStatus,
            radioValue: SubscriptionStatus.no,
            onChangeStatus: _changeStatus,
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

  void _changeStatus(SubscriptionStatus status) {
    setState(() => _subscriptionStatus = status);
  }
}

class _SubscriptionStatusRadio extends StatelessWidget {
  const _SubscriptionStatusRadio({
    Key? key,
    required this.subscriptionStatus,
    required this.radioValue,
    required this.onChangeStatus,
  }) : super(key: key);

  final SubscriptionStatus subscriptionStatus;
  final void Function(SubscriptionStatus newStatus) onChangeStatus;
  final SubscriptionStatus radioValue;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(radioValue.name),
      leading: Radio<SubscriptionStatus>(
        value: radioValue,
        groupValue: subscriptionStatus,
        onChanged: (status) {
          if (status != null) {
            onChangeStatus(status);
          }
        },
      ),
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
