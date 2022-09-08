enum SubscriptionStatus { yes, no }

class UserProfile {
  final String name;
  final String email;
  final DateTime birthday;
  final SubscriptionStatus subscriptionStatus;
  final String profilePictureUrl;

  UserProfile({
    required this.name,
    required this.email,
    required this.birthday,
    required this.subscriptionStatus,
    required this.profilePictureUrl,
  });
}
