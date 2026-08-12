import 'package:flutter/material.dart';

import '../../../core/models/item.dart';

class CustomItemResult {
  const CustomItemResult({
    required this.label,
    required this.type,
    required this.value,
  });

  final String label;
  final ItemType type;
  final int value;
}

/// A dialog for adding a custom onboarding item: a label (<=60 chars), a
/// type (filler/emptier), and an impact value (1-50), matching the backend
/// rules in section 8.2.
Future<CustomItemResult?> showAddCustomItemDialog(BuildContext context) {
  return showDialog<CustomItemResult>(
    context: context,
    builder: (context) => const _AddCustomItemDialog(),
  );
}

class _AddCustomItemDialog extends StatefulWidget {
  const _AddCustomItemDialog();

  @override
  State<_AddCustomItemDialog> createState() => _AddCustomItemDialogState();
}

class _AddCustomItemDialogState extends State<_AddCustomItemDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _valueController = TextEditingController(
    text: '10',
  );
  ItemType _type = ItemType.filler;

  @override
  void dispose() {
    _labelController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    Navigator.of(context).pop(
      CustomItemResult(
        label: _labelController.text.trim(),
        type: _type,
        value: int.parse(_valueController.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add custom item'),
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SegmentedButton<ItemType>(
              segments: const <ButtonSegment<ItemType>>[
                ButtonSegment<ItemType>(
                  value: ItemType.filler,
                  label: Text('Load'),
                  icon: Icon(Icons.add_circle_outline),
                ),
                ButtonSegment<ItemType>(
                  value: ItemType.emptier,
                  label: Text('Relief'),
                  icon: Icon(Icons.remove_circle_outline),
                ),
              ],
              selected: <ItemType>{_type},
              onSelectionChanged: (Set<ItemType> selection) =>
                  setState(() => _type = selection.first),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _labelController,
              decoration: const InputDecoration(labelText: 'Label'),
              maxLength: 60,
              textCapitalization: TextCapitalization.sentences,
              validator: (String? value) {
                final String trimmed = value?.trim() ?? '';
                if (trimmed.isEmpty) {
                  return 'Label is required.';
                }
                if (trimmed.length > 60) {
                  return 'Label must be 60 characters or fewer.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _valueController,
              decoration: const InputDecoration(
                labelText: 'Impact value (1-50)',
              ),
              keyboardType: TextInputType.number,
              validator: (String? value) {
                final int? parsed = int.tryParse(value?.trim() ?? '');
                if (parsed == null) {
                  return 'Enter a whole number.';
                }
                if (parsed < 1 || parsed > 50) {
                  return 'Value must be between 1 and 50.';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Add')),
      ],
    );
  }
}
