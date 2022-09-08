import 'package:flutter/material.dart';
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
          ElevatedButton.icon(
            icon: const Icon(Icons.change_circle),
            label: const Text('Change Profile Data'),
            onPressed: () {},
          ),
        ],
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
        onTap: () {},
      ),
    );
  }
}
