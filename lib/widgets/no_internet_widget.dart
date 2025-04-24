import 'package:ecommerce_getx_folderstructure/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../core/services/connectivity_service.dart';


class NoInternetWidget extends StatelessWidget {
  final VoidCallback? onRetry;

  const NoInternetWidget({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final ConnectivityService connectivityService = Get.find();

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Obx(() => Text(
                  connectivityService.isConnected.value
                      ? 'Slow or unstable connection'
                      : 'No internet connection',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            const SizedBox(height: 8),
            const Text(
              'Please check your mobile data or Wi-Fi connection.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Retry',
              onPressed: () async {
                await connectivityService.checkConnection();
                if (connectivityService.isConnected.value && onRetry != null) {
                  onRetry!();
                }
              },
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () async {
                await openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        ),
      ),
    );
  }
}