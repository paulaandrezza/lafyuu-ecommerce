import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lafyuu/models/enums/UserRole.dart';
import 'package:lafyuu/routes/app_routes.dart';
import 'package:lafyuu/services/auth_manager.dart';
import 'package:lafyuu/theme/app_colors.dart';
import 'package:lafyuu/theme/app_text_styles.dart';
import 'package:lafyuu/utils/form_validators.dart';
import 'package:lafyuu/widgets/primary_button.dart';
import 'package:lafyuu/widgets/social_login_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _emailError;
  String? _passwordError;

  void _handleSignIn() async {
    setState(
      () => {_isLoading = true, _emailError = null, _passwordError = null},
    );

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final emailError =
        FormValidators.required(email) ?? FormValidators.email(email);
    final passwordError = FormValidators.required(password);

    if (emailError != null || passwordError != null) {
      setState(() {
        _emailError = emailError;
        _passwordError = passwordError;
        _isLoading = false;
      });
      return;
    }

    final authManager = AuthManager();

    try {
      final user = await authManager.signIn(email, password);

      if (user.role == UserRole.seller) {
        Navigator.pushReplacementNamed(context, AppRoutes.sellerMain.path);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.main.path);
      }
    } catch (e) {
      setState(() {
        _emailError = '';
        _passwordError = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8,
            children: [
              const SizedBox(height: 16),
              SvgPicture.asset('assets/images/logo.svg', height: 80),
              const SizedBox(height: 16),

              Text('Welcome to Lafyuu', style: AppTextStyles.h2),

              Text('Sign in to continue', style: AppTextStyles.subtitle),
              const SizedBox(height: 24),

              TextField(
                controller: _emailController,
                style: TextStyle(color: AppColors.grey),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: AppColors.grey,
                  ),
                  hintText: 'Your Email',
                  errorText: _emailError,
                ),
              ),

              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.grey,
                  ),
                  hintText: 'Password',
                  errorText: _passwordError,
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: PrimaryButton(
                  label: 'Sign In',
                  onPressed: _handleSignIn,
                  isLoading: _isLoading,
                ),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                      endIndent: 16,
                    ),
                  ),
                  const Text(
                    'OR',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 16,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              SocialLoginButton(
                assetPath: 'assets/images/google_icon.png',
                label: 'Login with Google',
                onTap: () {},
              ),
              const SizedBox(height: 16),

              SocialLoginButton(
                assetPath: 'assets/images/facebook_icon.png',
                label: 'Login with facebook',
                onTap: () {},
              ),
              const SizedBox(height: 16),

              TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: AppTextStyles.bodyLightBlue,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppTextStyles.subtitle,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.signUp.path,
                      );
                    },
                    child: Text('Register', style: AppTextStyles.bodyLightBlue),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
