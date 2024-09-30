import 'package:flutter/material.dart';
import 'package:my_flutter_app/constants/colors.dart'; 

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed; 

  const SaveButton({super.key, required this.onPressed}); 

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed, 
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          fixedSize: const Size(260, 50), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(
            color: primaryWhite,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
