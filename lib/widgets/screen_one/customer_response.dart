import 'package:flutter/material.dart';
import 'package:my_flutter_app/constants/colors.dart';

class CustomerResponseSelector extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String?> onChanged;

  const CustomerResponseSelector({
    super.key,
    this.initialValue,
    required this.onChanged,
  });

  @override
  CustomerResponseSelectorState createState() =>
      CustomerResponseSelectorState();
}

class CustomerResponseSelectorState extends State<CustomerResponseSelector> {
  String? _selectedResponse;

  // List of options for "Customer Response"
  final List<String> _customerResponses = [
    'CPE HAS ALREADY COLLECTED',
    'AGREE TO SETTLE BILL',
    'REFUSED TO COLLECT CPES',
    'CUSTOMER NOT AVAILABLE',
    'AGREE TO COLLECT CPES',
  ];

  @override
  void initState() {
    super.initState();
    _selectedResponse = widget.initialValue;
  }

  // Method to show the dialog with radio options
  Future<void> _showCustomerResponseDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width *
                0.9, 
            constraints: const BoxConstraints(
              maxWidth: double.infinity, 
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, 
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Customer Response',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ..._customerResponses.map((String value) {
                    return RadioListTile<String>(
                      title: Text(value),
                      value: value,
                      groupValue: _selectedResponse,
                      activeColor: primaryBlue,
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 0.0),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedResponse = newValue;
                        });
                        widget
                            .onChanged(newValue); // Notify parent of the change
                        Navigator.of(context).pop(); 
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Customer Response',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: _showCustomerResponseDialog,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 12.0,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedResponse ?? 'Select Response',
                  style: TextStyle(
                      color: _selectedResponse != null
                          ? Colors.black
                          : primaryGrey,
                      fontSize: 16),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
