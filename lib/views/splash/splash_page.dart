import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lafyuu/routes/app_routes.dart';
import 'package:lafyuu/theme/app_colors.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      bool isLoggedIn = false;

      Navigator.pushReplacementNamed(
        context,
        isLoggedIn ? AppRoutes.main.path : AppRoutes.signIn.path,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: SvgPicture.asset(
          'assets/images/logo_white.svg',
          height: 80,
          width: 80,
        ),
      ),
    );
  }
}
