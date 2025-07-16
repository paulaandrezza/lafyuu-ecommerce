import 'package:lafyuu/models/enums/Gender.dart';

class UserDetails {
  final String fullName;
  final String username;
  final String profileImageUrl;
  final String email;
  final String phoneNumber;
  final Gender gender;
  final DateTime birthDate;

  UserDetails({
    required this.fullName,
    required this.username,
    required this.profileImageUrl,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.birthDate,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      fullName: json['name'],
      username: json['username'],
      profileImageUrl: json['profileUrl'] ?? '',
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      gender: Gender.values.firstWhere(
        (g) =>
            g.name.toLowerCase() == (json['gender']?.toString().toLowerCase()),
        orElse: () => Gender.other,
      ),
      birthDate:
          json['birthDate'] != null
              ? DateTime.tryParse(json['birthDate'].toString()) ??
                  DateTime(2000, 1, 1)
              : DateTime(2000, 1, 1),
    );
  }
}
