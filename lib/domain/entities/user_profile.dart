enum SubscriptionStatus { yes, no }

class UserProfile {
  const UserProfile({
    required this.name,
    required this.email,
    required this.birthday,
    required this.subscriptionStatus,
    this.profilePictureUrl =
        'https://docs.flutter.dev/assets/images/dash/Dash.png',
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
      );

  UserProfile copyWith({
    String? name,
    String? email,
    DateTime? birthday,
    SubscriptionStatus? subscriptionStatus,
    String? profilePictureUrl,
  }) =>
      UserProfile(
        name: name ?? this.name,
        email: email ?? this.email,
        birthday: birthday ?? this.birthday,
        subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
        profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      );
}
