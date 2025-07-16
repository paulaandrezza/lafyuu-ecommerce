import 'package:flutter/material.dart';
import 'package:lafyuu/services/account/account_service.dart';
import 'package:lafyuu/theme/app_colors.dart';
import 'package:lafyuu/utils/form_validators.dart';
import 'package:lafyuu/widgets/primary_button.dart';

class EditEmailPage extends StatefulWidget {
  final String currentEmail;

  const EditEmailPage({super.key, required this.currentEmail});

  @override
  State<EditEmailPage> createState() => _EditEmailPageState();
}

class _EditEmailPageState extends State<EditEmailPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controller;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentEmail);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await AccountService().patchField('email', _controller.text.trim());
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao salvar: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Email')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: TextFormField(
            controller: _controller,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: AppColors.dark),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email_outlined, color: AppColors.grey),
              hintText: 'Email',
            ),
            validator: (value) {
              final requiredError = FormValidators.required(value);
              if (requiredError != null) return requiredError;

              final isValidEmail = FormValidators.email(value);
              return isValidEmail;
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryButton(
              label: 'Save',
              onPressed: _save,
              isLoading: isLoading,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
