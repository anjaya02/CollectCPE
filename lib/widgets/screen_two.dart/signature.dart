import 'package:flutter/material.dart';
import 'package:my_flutter_app/Provider/form_data.dart';
import 'package:my_flutter_app/widgets/Buttons/clear.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'dart:convert';

class SignatureWidget extends StatefulWidget {
  const SignatureWidget({super.key});

  @override
  SignatureWidgetState createState() => SignatureWidgetState();
}

class SignatureWidgetState extends State<SignatureWidget> {
  @override
  Widget build(BuildContext context) {
    final formData = Provider.of<FormData>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Customer Signature',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            ClearButton(
              text: 'Clear',
              onPressed: () {
                formData.signatureController.clear();
                formData.setCustomerSignature(
                    ''); // Clear the saved signature in FormData
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 220,
          width: 330,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              // Show the saved signature as an image if it exists
              if (formData.customerSignature != null &&
                  formData.customerSignature!.isNotEmpty)
                Image.memory(
                  base64Decode(formData.customerSignature!),
                  fit: BoxFit.cover,
                  width: 330,
                  height: 220,
                ),
              Signature(
                controller: formData
                    .signatureController, // Use the controller from provider
                backgroundColor: Colors.transparent,
                width: 310,
                height: 210,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
