// lib/form_data.dart
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:signature/signature.dart';

class FormData with ChangeNotifier {
  // Signature Controller
  final SignatureController _signatureController = SignatureController();
  SignatureController get signatureController => _signatureController;

  // HomePage Fields
  String? serviceDropdown;
  String? rtom;
  String? serviceOrder;
  String? registrationId;
  String? serviceType;
  String? iptv;
  String? phoneClass;
  String? dpFdp;

  // ScreenOne Fields
  String? customerName;
  String? customerAddress;
  String? customerContact;
  String? customerResponse;
  List<String> selectedDevices = [];
  Map<String, String?> selectedModels = {};
  Map<String, String?> yesNoSelection = {};
  Map<String, File?> selectedImages = {};

  // ScreenTwo Fields
  String? customerSignature;
  String? textField;

  // Methods to update HomePage fields
  void setServiceDropdown(String? value) {
    serviceDropdown = value;
    notifyListeners();
  }

  void setRtom(String value) {
    rtom = value;
    notifyListeners();
  }

  void setServiceOrder(String value) {
    serviceOrder = value;
    notifyListeners();
  }

  void setRegistrationId(String value) {
    registrationId = value;
    notifyListeners();
  }

  void setServiceType(String value) {
    serviceType = value;
    notifyListeners();
  }

  void setIptv(String value) {
    iptv = value;
    notifyListeners();
  }

  void setPhoneClass(String value) {
    phoneClass = value;
    notifyListeners();
  }

  void setDpFdp(String value) {
    dpFdp = value;
    notifyListeners();
  }

  // Methods to update ScreenOne fields

  // Method to validate Customer Response
  bool isCustomerResponseValid() {
    return customerResponse != null && customerResponse!.isNotEmpty;
  }

  // FormData class
  bool isDeviceSelected() {
    return selectedDevices.isNotEmpty;
  }

// Method to validate that all selected devices have images
  bool areAllImagesSelected() {
    return selectedDevices.every((device) => selectedImages[device] != null);
  }

// Method to validate that all selected devices have models selected
  bool areAllModelsSelected() {
    return selectedDevices.every((device) => selectedModels[device] != null);
  }

// Method to validate that all selected devices have yes/no selections
  bool areAllYesNoSelectionsMade() {
    return selectedDevices.every((device) => yesNoSelection[device] != null);
  }

  void setCustomerName(String value) {
    customerName = value;
    notifyListeners();
  }

  void setCustomerAddress(String value) {
    customerAddress = value;
    notifyListeners();
  }

  void setCustomerContact(String value) {
    customerContact = value;
    notifyListeners();
  }

  void setCustomerResponse(String value) {
    customerResponse = value;
    notifyListeners();
  }

  void addDevice(String device) {
    selectedDevices.add(device);
    notifyListeners();
  }

  void setSelectedModel(String device, String model) {
    selectedModels[device] = model;
    notifyListeners();
  }

  void setYesNoSelection(String device, String selection) {
    yesNoSelection[device] = selection;
    notifyListeners();
  }

  void setSelectedImage(String device, File image) {
    selectedImages[device] = image;
    notifyListeners();
  }

  // Methods to update ScreenTwo fields
  
  // Method to validate Customer Signature
  // Update this method in your FormData class
  bool isCustomerSignatureValid() {
    return _signatureController
        .isNotEmpty; // Check if there is any signature drawn
  }

// Method to validate Customer Name
  bool isCustomerNameValid() {
    return customerName != null && customerName!.isNotEmpty;
  }

// Method to validate Customer Mobile Number (10 digits)
  bool isCustomerContactValid() {
    if (customerContact == null || customerContact!.isEmpty) {
      return false; // Invalid if empty
    }
    // Check if the length is exactly 10 digits
    return customerContact!.length == 10 &&
        RegExp(r'^\d+$')
            .hasMatch(customerContact!); // Ensures it only contains digits
  }

  void setCustomerSignature(String value) {
    customerSignature = value;
    notifyListeners();
  }

  void setTextField(String value) {
    textField = value;
    notifyListeners();
  }

  // Reset all fields if needed
  void reset() {
    serviceDropdown = null;
    rtom = null;
    serviceOrder = null;
    registrationId = null;
    serviceType = null;
    iptv = null;
    phoneClass = null;
    dpFdp = null;
    customerName = null;
    customerAddress = null;
    customerContact = null;
    customerResponse = null;
    selectedDevices.clear();
    selectedModels.clear();
    yesNoSelection.clear();
    selectedImages.clear();
    customerSignature = null;
    textField = null;
    notifyListeners();
  }
}
