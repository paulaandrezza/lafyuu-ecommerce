import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lafyuu/services/account/account_service.dart';
import 'package:lafyuu/theme/app_colors.dart';
import 'package:lafyuu/widgets/primary_button.dart';

class EditBirthDatePage extends StatefulWidget {
  final DateTime currentBirthDate;

  const EditBirthDatePage({super.key, required this.currentBirthDate});

  @override
  State<EditBirthDatePage> createState() => _EditBirthDatePageState();
}

class _EditBirthDatePageState extends State<EditBirthDatePage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime selectedDate;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.currentBirthDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _save() async {
    setState(() => isLoading = true);

    try {
      await AccountService().patchField(
        'birthDate',
        DateFormat('yyyy-MM-dd').format(selectedDate),
      );
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
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Birth Date')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.calendar_month_outlined,
                    color: AppColors.grey,
                  ),
                  hintText: 'Birth Date',
                ),
                controller: TextEditingController(text: formattedDate),
              ),
            ),
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
