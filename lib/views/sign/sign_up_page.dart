import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lafyuu/routes/app_routes.dart';
import 'package:lafyuu/services/auth_manager.dart';
import 'package:lafyuu/theme/app_colors.dart';
import 'package:lafyuu/theme/app_text_styles.dart';
import 'package:lafyuu/utils/form_validators.dart';
import 'package:lafyuu/widgets/primary_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controllers
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String? _selectedGender;

  String? _fullNameError;
  String? _usernameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _passwordMismatchError;
  String? _birthDateError;
  String? _phoneNumberError;
  String? _genderError;

  bool _isLoading = false;
  DateTime? _selectedBirthDate;

  Future<void> _selectBirthDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedBirthDate = pickedDate;
        _birthDateController.text =
            '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
        _birthDateError = null;
      });
    }
  }

  void _handleSignUp() async {
    setState(
      () => {
        _isLoading = true,
        _fullNameError = null,
        _usernameError = null,
        _emailError = null,
        _passwordError = null,
        _confirmPasswordError = null,
        _passwordMismatchError = null,
        _birthDateError = null,
        _phoneNumberError = null,
        _genderError = null,
      },
    );

    final fullName = _fullNameController.text.trim();
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final birthDate = _birthDateController.text;
    final phoneNumber = _phoneNumberController.text;

    final fullNameError = FormValidators.required(fullName);
    final usernameError =
        FormValidators.required(username) ??
        FormValidators.cannotContainSpaces(username);
    final emailError =
        FormValidators.required(email) ?? FormValidators.email(email);
    final passwordError = FormValidators.required(password);
    final confirmPasswordError = FormValidators.required(confirmPassword);
    final passwordMismatchError = FormValidators.passwordMatch(
      password,
      confirmPassword,
    );
    final birthDateError = FormValidators.required(birthDate);
    final phoneNumberError =
        FormValidators.required(phoneNumber) ??
        FormValidators.minLength(phoneNumber, 10);
    final genderError = FormValidators.required(_selectedGender);

    if (fullNameError != null ||
        usernameError != null ||
        emailError != null ||
        passwordError != null ||
        confirmPasswordError != null ||
        passwordMismatchError != null ||
        birthDateError != null ||
        phoneNumberError != null ||
        genderError != null) {
      setState(() {
        _fullNameError = fullNameError;
        _usernameError = usernameError;
        _emailError = emailError;
        _passwordError = passwordError;
        _confirmPasswordError = confirmPasswordError;
        _passwordMismatchError = passwordMismatchError;
        _birthDateError = birthDateError;
        _phoneNumberError = phoneNumberError;
        _genderError = genderError;
        _isLoading = false;
      });
      return;
    }

    final authManager = AuthManager();

    try {
      final user = await authManager.signUp(
        fullName,
        username,
        email,
        password,
        _selectedBirthDate!,
        phoneNumber,
        _selectedGender!,
      );

      _isLoading = false;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Account created successfully. Redirecting to singin...',
          ),
          backgroundColor: Colors.green,
        ),
      );

      await Future.delayed(const Duration(seconds: 2));

      Navigator.pushReplacementNamed(context, AppRoutes.signIn.path);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst('Exception: ', '')),
          backgroundColor: Colors.red,
        ),
      );
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

              Text('Let\'s Get Started', style: AppTextStyles.h2),

              Text('Create an new account', style: AppTextStyles.subtitle),
              const SizedBox(height: 24),

              TextField(
                controller: _fullNameController,
                style: TextStyle(color: AppColors.grey),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: AppColors.grey,
                  ),
                  hintText: 'Full Name',
                  errorText: _fullNameError,
                ),
              ),

              TextField(
                controller: _usernameController,
                style: TextStyle(color: AppColors.grey),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: AppColors.grey,
                  ),
                  hintText: 'Username',
                  errorText: _usernameError,
                ),
              ),

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
                  errorText:
                      _passwordError ??
                      (_passwordMismatchError != null
                          ? _passwordMismatchError ?? ""
                          : null),
                  errorStyle:
                      !(_passwordError != null) &&
                              _passwordMismatchError != null
                          ? TextStyle(height: 0, fontSize: 0)
                          : null,
                ),
              ),

              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.grey,
                  ),
                  hintText: 'Password Again',
                  errorText: _confirmPasswordError ?? _passwordMismatchError,
                ),
              ),

              GestureDetector(
                onTap: _selectBirthDate,
                child: AbsorbPointer(
                  child: TextField(
                    controller: _birthDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.calendar_month_outlined,
                        color: AppColors.grey,
                      ),
                      hintText: 'Birth Date',
                      errorText: _birthDateError,
                    ),
                  ),
                ),
              ),

              // TODO: Adicionar máscara de telefone
              TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.phone_outlined,
                    color: AppColors.grey,
                  ),
                  hintText: 'Phone Number',
                  errorText: _phoneNumberError,
                ),
              ),

              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.wc_outlined,
                    color: AppColors.grey,
                  ),
                  hintText: 'Gender',
                  errorText: _genderError,
                ),
                items:
                    ['Male', 'Female', 'Other']
                        .map(
                          (gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                    _genderError = null;
                  });
                },
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: PrimaryButton(
                  label: 'Sign Up',
                  onPressed: _handleSignUp,
                  isLoading: _isLoading,
                ),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("have an account? ", style: AppTextStyles.subtitle),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.signIn.path,
                      );
                    },
                    child: Text('Sign In', style: AppTextStyles.bodyLightBlue),
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
