import 'package:flutter/material.dart';
import 'package:formulastudent/src/view/utils/snackbar_provider.dart';
import 'package:get/get.dart';

class SnackBarProviderImpl extends GetxController implements SnackBarProvider{

  @override
  void provideErrorSnackBack(String cause){
    Get.snackbar(
      "Error",
      cause,
      icon: Icon(Icons.error_outline, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      borderRadius: 16,
      margin: EdgeInsets.all(8),
      colorText: Colors.white,
      duration: Duration(seconds: 4),
      isDismissible: true,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}