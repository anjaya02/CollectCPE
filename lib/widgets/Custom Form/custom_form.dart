import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/Provider/form_data.dart';
import 'package:my_flutter_app/model/read_only.dart';
import 'package:my_flutter_app/widgets/Buttons/save_button.dart';
import 'package:my_flutter_app/widgets/Buttons/secondary_button.dart';
import 'package:my_flutter_app/widgets/home/service_dropdown.dart';
import 'package:my_flutter_app/constants/colors.dart';
import 'package:my_flutter_app/widgets/Buttons/nav_button.dart';
import 'package:my_flutter_app/widgets/screen_one/customer_response.dart';
import 'package:my_flutter_app/widgets/screen_two.dart/signature.dart';
import 'package:my_flutter_app/widgets/screen_two.dart/text_fields.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class CustomForm extends StatefulWidget {
  final bool showServiceDropdown;
  final bool showRtom;
  final bool showServiceOrder;
  final bool showRegistrationId;
  final bool showServiceType;
  final bool showIptv;
  final bool showPhoneClass;
  final bool showDpFdp;
  final bool showCustomerName;
  final bool showCustomerAddress;
  final bool showCustomerContact;
  final bool showCustomerResponse;
  final bool showDeviceSelection;
  final bool showCustomerSignature;
  final bool showTextFields;
  final bool showSaveButton;

  const CustomForm({
    super.key,
    this.showServiceDropdown = false,
    this.showRtom = false,
    this.showServiceOrder = false,
    this.showRegistrationId = false,
    this.showServiceType = false,
    this.showIptv = false,
    this.showPhoneClass = false,
    this.showDpFdp = false,
    this.showCustomerName = false,
    this.showCustomerAddress = false,
    this.showCustomerContact = false,
    this.showCustomerResponse = false,
    this.showDeviceSelection = false,
    this.showCustomerSignature = false,
    this.showTextFields = false,
    this.showSaveButton = false,
  });

  @override
  CustomFormState createState() => CustomFormState();
}

class CustomFormState extends State<CustomForm> {
  // GlobalKey
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<String> _availableModels = ['Model 1', 'Model 2', 'Model 3'];

  // Method to show the dialog with device options
  Future<void> _showDeviceDialog(FormData formData) async {
    List<String> availableDevices = ['ONT 1', 'STB 1', 'STB 2', 'STB 3']
        .where((device) => !formData.selectedDevices.contains(device))
        .toList();

    // Only show the dialog if there are available devices
    if (availableDevices.isNotEmpty) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select Device'),
            content: SingleChildScrollView(
              child: Column(
                children: availableDevices.map((String device) {
                  return ListTile(
                    title: Text(device),
                    onTap: () {
                      formData.addDevice(device); // Add device to FormData
                      Navigator.of(context).pop(); 
                    },
                  );
                }).toList(),
              ),
            ),
          );
        },
      );
    }
  }

  // Method to show the dialog with radio options for models
  Future<void> _showModelSelectionDialog(
      String device, FormData formData) async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Model for $device'),
          content: SingleChildScrollView(
            child: Column(
              children: _availableModels.map((String model) {
                return RadioListTile<String>(
                  title: Text(model),
                  value: model,
                  groupValue: formData.selectedModels[device],
                  activeColor: primaryBlue,
                  onChanged: (String? newValue) {
                    formData.setSelectedModel(
                        device, newValue!); // Set selected model in FormData
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  // Method to capture image for a specific device
  Future<void> _pickImageFromCamera(String device, FormData formData) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage != null) {
      formData.setSelectedImage(
          device, File(returnedImage.path)); // Store image in FormData
    }
  }

  bool validateBasicFormFields() {
    // Validate basic form fields (e.g., TextFormFields, dropdowns)
    if (formKey.currentState?.validate() ?? false) {
      return true; // All fields are valid
    }
    return false; // When fields are invalid
  }

  bool validateCustomerResponse() {
    final formData = Provider.of<FormData>(context, listen: false);

    // Check if customer response is selected
    if (formData.isCustomerResponseValid()) {
      return true; 
    } else {
      // Shows an error if customer response is not selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a customer response.')),
      );
      return false;
    }
  }

  bool validateDeviceSelection() {
    final formData = Provider.of<FormData>(context, listen: false);

    if (formData.isDeviceSelected()) {
      return true;
    } else {
      // Show an error if no device is selected
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Validation Error'),
            content: const Text('Please select at least one device.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return false;
    }
  }

// Validate that images are selected
  bool validateImagesSelected() {
    final formData = Provider.of<FormData>(context, listen: false);

    if (!formData.areAllImagesSelected()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please capture images for all devices.')),
      );
      return false; 
    }
    return true; 
  }

// Validate that models are selected
  bool validateModelsSelected() {
    final formData = Provider.of<FormData>(context, listen: false);

    if (!formData.areAllModelsSelected()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select models for all devices.')),
      );
      return false; 
    }
    return true; 
  }

// Validate that yes/no selections are made
  bool validateYesNoSelections() {
    final formData = Provider.of<FormData>(context, listen: false);

    if (!formData.areAllYesNoSelectionsMade()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please make yes/no selections for all devices.')),
      );
      return false; 
    }
    return true; 
  }

  bool validateForm() {
    // First, validate basic form fields
    if (!validateBasicFormFields()) {
      return false;
    }

    // Then, validate customer response
    if (!validateCustomerResponse()) {
      return false;
    }

    // Validate device selection
    if (!validateDeviceSelection()) {
      return false;
    }

    // Validate that images are selected
    if (!validateImagesSelected()) {
      return false;
    }

    // Validate that models are selected
    if (!validateModelsSelected()) {
      return false;
    }

    // Validate that yes/no selections are made
    if (!validateYesNoSelections()) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    // Access the FormData state using Provider
    final formData = Provider.of<FormData>(context);

    return Center(
      child: Form(
        key: formKey,
        child: Container(
          decoration: BoxDecoration(
            color: primaryWhite,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.showServiceDropdown)
                ServiceDropdown(onChanged: (selectedValue) {
                  // Handle selected service change
                }),
              const SizedBox(height: 1),
              if (widget.showRtom)
                const ReadOnlyField(
                  label: 'RTOM',
                  value: 'RTOM ',
                  placeholder: 'RTOM',
                ),
              const SizedBox(height: 1),
              if (widget.showServiceOrder)
                const ReadOnlyField(
                  label: 'Service Order',
                  value: 'Service Order ',
                  placeholder: 'Service Order',
                ),
              const SizedBox(height: 1),
              if (widget.showRegistrationId)
                const ReadOnlyField(
                  label: 'Registration ID',
                  value: 'Registration ID',
                  placeholder: 'Registration ID',
                ),
              const SizedBox(height: 1),
              if (widget.showServiceType)
                const ReadOnlyField(
                  label: 'Service Type',
                  value: 'Service Type',
                  placeholder: 'Service Type',
                ),
              const SizedBox(height: 1),
              if (widget.showIptv)
                const ReadOnlyField(
                  label: 'IPTV',
                  value: 'IPTV',
                  placeholder: 'IPTV',
                ),
              const SizedBox(height: 1),
              if (widget.showPhoneClass)
                const ReadOnlyField(
                  label: 'Phone Class',
                  value: 'Phone Class',
                  placeholder: 'Phone Class',
                ),
              const SizedBox(height: 1),
              if (widget.showDpFdp)
                const ReadOnlyField(
                  label: 'DP/FDP',
                  value: 'DP/FDP',
                  placeholder: 'DP/FDP',
                ),

              const SizedBox(height: 1),
              if (widget.showCustomerName)
                const ReadOnlyField(
                  label: 'Customer Name',
                  value: 'Customer Name',
                  placeholder: 'Customer Name',
                ),
              const SizedBox(height: 1),
              if (widget.showCustomerAddress)
                const ReadOnlyField(
                  label: 'Customer Address',
                  value: 'Customer Address',
                  placeholder: 'Customer Address',
                ),
              const SizedBox(height: 1),
              if (widget.showCustomerContact)
                const ReadOnlyField(
                  label: 'Customer Contact',
                  value: 'Customer Contact',
                  placeholder: 'Customer Contact',
                ),

              const SizedBox(height: 1),
              // "Customer Response" field
              if (widget.showCustomerResponse)
                CustomerResponseSelector(
                  initialValue: formData.customerResponse,
                  onChanged: (String? newValue) {
                    formData.setCustomerResponse(
                        newValue!); // Update the state in FormData
                  },
                ),

              const SizedBox(height: 11),

              // Conditionally show "Select a Device" and "Add" button
              if (widget.showDeviceSelection)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: primaryGrey.shade300,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Text(
                        'Select a Device',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    CustomButton(
                      text: 'Add',
                      backgroundColor: primaryBlue,
                      onPressed: () {
                        // Show the dialog only if not all devices have been selected
                        if (formData.selectedDevices.length < 4) {
                          _showDeviceDialog(formData);
                        } else {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            title: 'Oops',
                            text: 'All devices have been selected!',
                            confirmBtnText: 'OK',
                            confirmBtnColor: primaryBlue,
                          );
                        }
                      },
                    ),
                  ],
                ),

              const SizedBox(height: 1),

              // Only show devices if device selection is enabled
              if (widget.showDeviceSelection)
                ...formData.selectedDevices.reversed.map(
                  (device) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(color: Colors.grey, thickness: 1),
                          Text(device,
                              style: const TextStyle(color: Colors.black)),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 12.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  child: const Text(
                                    'Serial Number',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 48.0,
                                height: 48.0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _pickImageFromCamera(device, formData);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryGreen,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: const Icon(
                                      Icons.document_scanner_outlined,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          formData.selectedImages[device] != null
                              ? Image.file(formData.selectedImages[device]!)
                              : const Text('Please capture the serial number.'),
                          const SizedBox(height: 16),
                          Text('$device Model'),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () {
                              _showModelSelectionDialog(device, formData);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 12.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8.0),
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  formData.selectedModels[device] ??
                                      'Select a Model',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text('$device Reuserble'),
                          const SizedBox(height: 1),
                          Row(
                            children: [
                              const SizedBox(width: 5),
                              Radio<String>(
                                value: 'Yes',
                                groupValue: formData.yesNoSelection[device],
                                onChanged: (String? newValue) {
                                  formData.setYesNoSelection(device, newValue!);
                                },
                                activeColor: primaryBlue,
                              ),
                              const Text('Yes'),
                              const Spacer(),
                              Radio<String>(
                                value: 'No',
                                groupValue: formData.yesNoSelection[device],
                                onChanged: (String? newValue) {
                                  formData.setYesNoSelection(device, newValue!);
                                },
                                activeColor: primaryBlue,
                              ),
                              const Text('No'),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SecondaryButton(
                                text: 'NO Serial',
                                backgroundColor: primaryBlue,
                                textColor: primaryWhite,
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('NO Serial button pressed')),
                                  );
                                },
                              ),
                              const SizedBox(width: 2),
                              SecondaryButton(
                                text: 'NO CPE',
                                backgroundColor: primaryWhite,
                                textColor: primaryBlue,
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('NO CPE button pressed')),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),

              // Signature section
              if (widget.showCustomerSignature)
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SignatureWidget(),
                    SizedBox(height: 10),
                  ],
                ),

              // Text fields section
              if (widget.showTextFields) const TextFields(),
              const SizedBox(height: 30),
              // Save button
              if (widget.showSaveButton)
                SaveButton(
                  onPressed: () {
                    final formData =
                        Provider.of<FormData>(context, listen: false);
                    // Start with a flag to check if validations pass
                    bool isValid = true;
                    String errorMessage = '';

                    // Validate signature
                    if (!formData.isCustomerSignatureValid()) {
                      isValid = false;
                      errorMessage = 'Please provide a customer signature.';
                    }
                    // Validate customer name
                    else if (!formData.isCustomerNameValid()) {
                      isValid = false;
                      errorMessage = 'Please enter the customer name.';
                    }
                    // Validate customer contact
                    else if (!formData.isCustomerContactValid()) {
                      isValid = false;
                      errorMessage =
                          'Please enter a valid 10-digit mobile number.';
                    }

                    // If validation fails, show a warning alert
                    if (!isValid) {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.warning,
                        title: 'Action Required',
                        text: errorMessage,
                        confirmBtnText: 'OK',
                        confirmBtnColor: primaryBlue,
                      );
                    } else {
                      // If validation passes, show a confirmation dialog
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.confirm,
                        title: 'Are you sure?',
                        text: 'Sure to Submit',
                        confirmBtnText: 'Yes',
                        cancelBtnText: 'No',
                        confirmBtnColor: primaryGreen,
                        onConfirmBtnTap: () {
                          Navigator.of(context).pop();

                          // Show success alert after confirmation
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            title: 'Success',
                            text: 'Form submitted successfully!',
                            confirmBtnText: 'OK',
                            confirmBtnColor: primaryBlue,
                            onConfirmBtnTap: () {
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
