enum SubscriptionStatus { yes, no }

class UserProfile {
  const UserProfile({
    required this.name,
    required this.email,
    required this.birthday,
    required this.subscriptionStatus,
    required this.profilePictureUrl,
  });

  final String name;
  final String email;
  final DateTime birthday;
  final SubscriptionStatus subscriptionStatus;
  final String profilePictureUrl;

  factory UserProfile.byDefault() => UserProfile(
        name: 'Ben',
        email: 'ben@gmail.com',
        birthday: DateTime(1995, 4, 5),
        subscriptionStatus: SubscriptionStatus.yes,
        profilePictureUrl:
            'https://docs.flutter.dev/assets/images/dash/Dash.png',
      );
}
