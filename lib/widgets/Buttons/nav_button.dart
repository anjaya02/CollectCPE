import 'package:flutter/material.dart';
import 'package:my_flutter_app/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final bool isEnabled;

  const CustomButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? backgroundColor : primaryGrey,
        disabledBackgroundColor: primaryGrey,
        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: primaryWhite,
          fontSize: 18,
        ),
      ),
    );
  }
}
