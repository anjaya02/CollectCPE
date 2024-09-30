import 'package:flutter/material.dart';
import 'package:my_flutter_app/constants/colors.dart';
import 'package:my_flutter_app/Provider/form_data.dart';
import 'package:provider/provider.dart';

class ServiceDropdown extends StatelessWidget {
  final Function(String) onChanged;

  const ServiceDropdown({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    // Access the FormData instance via Provider
    final formData = Provider.of<FormData>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Service',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: formData.serviceDropdown,
                hint: const Text('Select a Service'),
                items: [
                  'Service 1',
                  'Service 2',
                  'Service 3',
                  'Service 4',
                  'Service 5',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  formData.setServiceDropdown(newValue); // Update FormData
                  onChanged(newValue ?? ''); // Notify parent of the change
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a service';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: primaryBlue, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14.0,
                    horizontal: 12.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 51,
              height: 51,
              child: ElevatedButton(
                onPressed: () {
                  // Reset the dropdown
                  formData.setServiceDropdown(null);
                  onChanged(''); // Notify parent of reset
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Transform.translate(
                  offset: const Offset(-11.0, 0.0),
                  child: const Icon(
                    Icons.refresh,
                    size: 26.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
