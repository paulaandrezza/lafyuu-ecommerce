import 'package:flutter/material.dart';
import 'package:lafyuu/services/account/account_service.dart';
import 'package:lafyuu/theme/app_colors.dart';
import 'package:lafyuu/widgets/primary_button.dart';
import 'package:lafyuu/utils/form_validators.dart'; // certifique-se de importar corretamente

class EditPhoneNumberPage extends StatefulWidget {
  final String currentPhoneNumber;

  const EditPhoneNumberPage({super.key, required this.currentPhoneNumber});

  @override
  State<EditPhoneNumberPage> createState() => _EditPhoneNumberPageState();
}

class _EditPhoneNumberPageState extends State<EditPhoneNumberPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controller;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentPhoneNumber);
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
      await AccountService().patchField('phoneNumber', _controller.text.trim());
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
      appBar: AppBar(title: const Text('Edit Phone Number')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: TextFormField(
            controller: _controller,
            keyboardType: TextInputType.phone,
            style: const TextStyle(color: AppColors.dark),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.phone_android, color: AppColors.grey),
              hintText: 'Phone Number',
            ),
            validator: (value) {
              final required = FormValidators.required(value);
              if (required != null) return required;

              return FormValidators.minLength(value, 10);
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
