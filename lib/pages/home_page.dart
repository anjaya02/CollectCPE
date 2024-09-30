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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    // Create a GlobalKey for the CustomFormState
    final GlobalKey<CustomFormState> formKey = GlobalKey<CustomFormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<FormData>(
                    builder: (context, formData, child) {
                      return CustomForm(
                        key: formKey, // Pass the GlobalKey to CustomForm
                        showServiceDropdown: true,
                        showRtom: true,
                        showServiceOrder: true,
                        showRegistrationId: true,
                        showServiceType: true,
                        showIptv: true,
                        showPhoneClass: true,
                        showDpFdp: true,
                        showCustomerResponse: false,
                        showDeviceSelection: false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
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
                      CustomButton(
                        text: 'Back',
                        backgroundColor: primaryBlue,
                        isEnabled: false,
                        onPressed: () {},
                      ),
                      CustomButton(
                        text: 'Next',
                        backgroundColor: primaryGreen,
                        onPressed: () {
                          if (formKey.currentState!.validateBasicFormFields()) {
                            // If form is valid, navigate to the next screen
                            context.go('/screen-one');
                          } else {
                            // If form is not valid, show a QuickAlert warning dialog
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.warning,
                              title: 'Action Required',
                              text: 'Please select a service.',
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
