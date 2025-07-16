import 'package:flutter/material.dart';
import 'package:lafyuu/theme/app_text_styles.dart';

class SocialLoginButton extends StatelessWidget {
  final String assetPath;
  final String label;
  final VoidCallback onTap;

  const SocialLoginButton({
    super.key,
    required this.assetPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Image.asset(assetPath, height: 20),
      label: Text(label, style: AppTextStyles.subtitle2),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
