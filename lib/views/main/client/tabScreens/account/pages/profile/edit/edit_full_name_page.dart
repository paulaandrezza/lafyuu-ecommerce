import 'package:flutter/material.dart';
import 'package:lafyuu/services/account/account_service.dart';
import 'package:lafyuu/theme/app_colors.dart';
import 'package:lafyuu/utils/form_validators.dart';
import 'package:lafyuu/widgets/primary_button.dart';

class EditFullNamePage extends StatefulWidget {
  final String currentFullName;

  const EditFullNamePage({super.key, required this.currentFullName});

  @override
  State<EditFullNamePage> createState() => _EditFullNamePageState();
}

class _EditFullNamePageState extends State<EditFullNamePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controller;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentFullName);
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
      await AccountService().patchField('fullName', _controller.text.trim());
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
      appBar: AppBar(title: const Text('Edit Full Name')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: TextFormField(
            controller: _controller,
            style: const TextStyle(color: AppColors.dark),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person_outline, color: AppColors.grey),
              hintText: 'Full Name',
            ),
            validator: FormValidators.required,
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
