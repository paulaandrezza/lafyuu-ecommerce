import 'package:flutter/material.dart';
import 'package:lafyuu/models/enums/Gender.dart';
import 'package:lafyuu/services/account/account_service.dart';
import 'package:lafyuu/theme/app_colors.dart';
import 'package:lafyuu/widgets/primary_button.dart';

class EditGenderPage extends StatefulWidget {
  final Gender currentGender;

  const EditGenderPage({super.key, required this.currentGender});

  @override
  State<EditGenderPage> createState() => _EditGenderPageState();
}

class _EditGenderPageState extends State<EditGenderPage> {
  late String? selectedGender;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    selectedGender = widget.currentGender.name;
  }

  Future<void> _save() async {
    isLoading = true;

    try {
      await AccountService().patchField('gender', selectedGender!);
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
      appBar: AppBar(title: const Text('Edit Gender')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedGender,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.wc_outlined,
                  color: AppColors.grey,
                ),
                hintText: 'Gender',
              ),
              items:
                  Gender.values.map((gender) {
                    return DropdownMenuItem<String>(
                      value: gender.name,
                      child: Text(gender.name),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
            ),
          ],
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
