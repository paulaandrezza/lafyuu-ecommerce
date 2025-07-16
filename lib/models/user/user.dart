import 'package:lafyuu/models/enums/UserRole.dart';

class User {
  final String userId;
  final UserRole role;

  User({required this.userId, required this.role});
}
