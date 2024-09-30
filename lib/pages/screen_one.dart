import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/constants/colors.dart';
import 'package:my_flutter_app/Provider/form_data.dart';
import 'package:my_flutter_app/AppBar/app_bar.dart';
import 'package:my_flutter_app/widgets/Custom%20Form/custom_form.dart';
import 'package:my_flutter_app/widgets/Buttons/nav_button.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

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
            padding: const EdgeInsets.only(bottom: 80.0),
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
                        showCustomerName: true,
                        showCustomerAddress: true,
                        showCustomerContact: true,
                        showCustomerResponse: true,
                        showDeviceSelection: true,
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
                          // Navigate to Home
                          context.go('/');
                        },
                      ),
                      CustomButton(
                        text: 'Next',
                        backgroundColor: primaryGreen,
                        onPressed: () {
                          // Access FormData state using Provider
                          final formData =
                              Provider.of<FormData>(context, listen: false);

                          // Start with a flag to check if validations pass
                          bool isValid = true;
                          String errorMessage = '';

                          // Check specific validations for ScreenOne
                          if (!formData.isCustomerResponseValid()) {
                            isValid = false;
                            errorMessage = 'Please select a customer response.';
                          } else if (!formData.isDeviceSelected()) {
                            isValid = false;
                            errorMessage = 'Please select at least one device.';
                          } else if (!formData.areAllImagesSelected()) {
                            isValid = false;
                            errorMessage =
                                'Please capture the serial number for all devices';
                          } else if (!formData.areAllModelsSelected()) {
                            isValid = false;
                            errorMessage =
                                'Please select models for all devices.';
                          } else if (!formData.areAllYesNoSelectionsMade()) {
                            isValid = false;
                            errorMessage =
                                'Please make yes/no selections for all devices.';
                          }

                          // If all validations pass, navigate to the next screen
                          if (isValid) {
                            context.go('/screen-two');
                          } else {
                            // Show a QuickAlert warning for validation error
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.warning,
                              title: 'Action Required',
                              text: errorMessage,
                              confirmBtnText: 'OK',
                              confirmBtnColor: primaryBlue,
                            );
                          }
                        },
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
