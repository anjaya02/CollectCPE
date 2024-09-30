import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/Provider/form_data.dart';
import 'package:my_flutter_app/constants/colors.dart';
import 'package:my_flutter_app/widgets/Custom%20Form/custom_form.dart';
import 'package:my_flutter_app/AppBar/app_bar.dart';
import 'package:my_flutter_app/widgets/Buttons/nav_button.dart';
import 'package:provider/provider.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if the keyboard is open
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(), // Custom AppBar widget
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              bottom: 80.0,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Using the Consumer to access the FormData state
                  Consumer<FormData>(
                    builder: (context, formData, child) {
                      // Return the CustomForm widget
                      return const CustomForm(
                        showCustomerSignature: true,
                        showTextFields: true,
                        showSaveButton: true,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Conditionally render the buttons based on keyboard visibility
          if (!isKeyboardVisible)
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 27, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Use the CustomButton widget
                      CustomButton(
                        text: 'Back',
                        backgroundColor: primaryBlue,
                        onPressed: () {
                          // Navigate to ScreenOne
                          context.go('/screen-one');
                        },
                      ),
                      CustomButton(
                        text: 'Next',
                        backgroundColor: primaryGreen,
                        isEnabled: false,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
