import 'package:flutter/material.dart';
import 'package:lafyuu/presentation/models/profile_info_item.dart';

List<ProfileInfoItemData> buildProfileInfoItems({
  required String gender,
  required String birthDate,
  required String email,
  required String phoneNumber,
  required Map<String, VoidCallback> onTapActions,
}) {
  return [
    ProfileInfoItemData(
      icon: Icons.transgender_outlined,
      label: 'Gender',
      value: gender,
      onTap: onTapActions['gender'] ?? () {},
    ),
    ProfileInfoItemData(
      icon: Icons.calendar_month_outlined,
      label: 'Birthday',
      value: birthDate,
      onTap: onTapActions['birthDate'] ?? () {},
    ),
    ProfileInfoItemData(
      icon: Icons.email_outlined,
      label: 'Email',
      value: email,
      onTap: onTapActions['email'] ?? () {},
    ),
    ProfileInfoItemData(
      icon: Icons.phone_android,
      label: 'Phone Number',
      value: phoneNumber,
      onTap: onTapActions['phoneNumber'] ?? () {},
    ),
    ProfileInfoItemData(
      icon: Icons.lock,
      label: 'Change Password',
      value: '**********',
      onTap: onTapActions['password'] ?? () {},
    ),
  ];
}
