import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ConnectivityService extends GetxController {
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Listen for connectivity changes
    Connectivity().onConnectivityChanged.listen((result) {
      updateConnectionStatus(result);
    });
    // Initial check
    checkConnection();
  }

  Future<bool> checkConnection() async {
    try {
      final result = await Connectivity().checkConnectivity();
      updateConnectionStatus(result);
      return isConnected.value;
    } catch (e) {
      isConnected.value = false;
      return false;
    }
  }

  void updateConnectionStatus(List<ConnectivityResult> result) {
    isConnected.value = result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi);
    if (!isConnected.value) {
      showNoInternetDialog();
    }
  }

  void showNoInternetDialog() {
    if (!Get.isDialogOpen!) {
      Get.dialog(
        AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text(
              'Please enable mobile data or Wi-Fi to continue using the app.'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Get.back();
                await openAppSettings(); // Navigate to system settings
              },
              child: const Text('Open Settings'),
            ),
          ],
        ),
        barrierDismissible: false,
      );
    }
  }
}