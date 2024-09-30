import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_flutter_app/constants/colors.dart';
import 'package:my_flutter_app/Provider/form_data.dart';

class TextFields extends StatelessWidget {
  const TextFields({super.key});

  @override
  Widget build(BuildContext context) {
    final formData = Provider.of<FormData>(context);

    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Signed Customer Name Field
          const Text(
            'Signed Customer Name',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue:
                formData.customerName ?? '', // Load initial value from FormData
            onChanged: (value) {
              formData.setCustomerName(value); // Save to FormData
            },
            cursorColor: primaryBlue,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: primaryBlue,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Signed Customer Mobile No Field
          const Text(
            'Signed Customer Mobile No',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: formData.customerContact ??
                '', // Load initial value from FormData
            onChanged: (value) {
              formData.setCustomerContact(value); // Save to FormData
            },
            cursorColor: primaryBlue, // Set cursor color
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: primaryBlue,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Remarks Field
          const Text(
            'Remarks',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue:
                formData.textField ?? '', // Load initial value from FormData
            onChanged: (value) {
              formData.setTextField(value); // Save to FormData
            },
            cursorColor: primaryBlue,
            maxLines: 4,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: primaryBlue,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
