import 'package:flutter/material.dart';

class ReadOnlyField extends StatelessWidget {
  final String label;
  final String value;
  final String placeholder;

  const ReadOnlyField({
    super.key,
    required this.label,
    required this.value,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 1),
          TextFormField(
            enabled: false,
            initialValue: value,
            decoration: InputDecoration(
              hintText: placeholder,
              border: const OutlineInputBorder(),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            ),
          ),
        ],
      ),
    );
  }
}
