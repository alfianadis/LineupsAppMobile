import 'package:flutter/material.dart';
import 'package:lineups/features/aspek/data/models/aspek_model.dart';
import 'package:lineups/service/api_service.dart';

class EditAspekScreen extends StatefulWidget {
  final AspekModel aspek;

  const EditAspekScreen({Key? key, required this.aspek}) : super(key: key);

  @override
  _EditAspekScreenState createState() => _EditAspekScreenState();
}

class _EditAspekScreenState extends State<EditAspekScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _assessmentAspectController;
  late TextEditingController _percentageController;
  late TextEditingController _coreFactorController;
  late TextEditingController _secondaryFactorController;

  @override
  void initState() {
    super.initState();
    _assessmentAspectController =
        TextEditingController(text: widget.aspek.assessmentAspect);
    _percentageController =
        TextEditingController(text: widget.aspek.percentage.toString());
    _coreFactorController =
        TextEditingController(text: widget.aspek.coreFactor.toString());
    _secondaryFactorController =
        TextEditingController(text: widget.aspek.secondaryFactor.toString());
  }

  @override
  void dispose() {
    _assessmentAspectController.dispose();
    _percentageController.dispose();
    _coreFactorController.dispose();
    _secondaryFactorController.dispose();
    super.dispose();
  }

  void _updateAspek() async {
    if (_formKey.currentState!.validate()) {
      AspekModel updatedAspek = AspekModel(
        id: widget.aspek.id,
        assessmentAspect: _assessmentAspectController.text,
        percentage: int.parse(_percentageController.text),
        coreFactor: int.parse(_coreFactorController.text),
        secondaryFactor: int.parse(_secondaryFactorController.text),
        createdAt: widget.aspek.createdAt, // Gunakan waktu asli untuk createdAt
        updatedAt: DateTime.now(),
        v: widget.aspek.v,
      );

      print('Updating aspek: ${updatedAspek.toJson()}');

      bool success = await ApiService().updateAspek(updatedAspek);
      if (success) {
        Navigator.pop(context, true); // Return true to indicate success
      } else {
        print('Update failed');
        // Handle error, show snackbar, etc.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Aspek'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _assessmentAspectController,
              decoration: const InputDecoration(labelText: 'Assessment Aspect'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an assessment aspect';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _percentageController,
              decoration: const InputDecoration(labelText: 'Percentage'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a percentage';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _coreFactorController,
              decoration: const InputDecoration(labelText: 'Core Factor'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a core factor';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _secondaryFactorController,
              decoration: const InputDecoration(labelText: 'Secondary Factor'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a secondary factor';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _updateAspek,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
