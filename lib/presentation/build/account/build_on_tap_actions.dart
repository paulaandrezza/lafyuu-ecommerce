import 'package:flutter/material.dart';
import 'package:lafyuu/models/user/user_details.dart';

Map<String, VoidCallback> buildOnTapActions(
  BuildContext context,
  UserDetails userDetails,
) {
  return {
    'gender': () {
      Navigator.pushNamed(
        context,
        '/edit/gender',
        arguments: userDetails.gender,
      );
    },
    'birthDate': () {
      Navigator.pushNamed(
        context,
        '/edit/birthDate',
        arguments: userDetails.birthDate,
      );
    },
    'email': () {
      Navigator.pushNamed(context, '/edit/email', arguments: userDetails.email);
    },
    'phoneNumber': () {
      Navigator.pushNamed(
        context,
        '/edit/phoneNumber',
        arguments: userDetails.phoneNumber,
      );
    },
    'password': () {
      Navigator.pushNamed(context, '/edit/password');
    },
  };
}
