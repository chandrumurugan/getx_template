import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../core/services/api_service.dart';
import '../../../core/storage/storage_service.dart';

class AuthController extends GetxController {
  final ApiService apiService = Get.find();
  final StorageService storageService = Get.find();
  var isLoggedIn = false.obs;
  var isLoading = false.obs;

  void login(String email, String password, BuildContext context) async {
    try {
      isLoading.value = true;
      final token = await apiService.login(email, password);
      storageService.saveUserToken(token);
      isLoggedIn.value = true;
      context.go('/products');
    } catch (e) {
      Get.snackbar( e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void logout(BuildContext context) {
    storageService.removeUserToken();
    isLoggedIn.value = false;
    context.go('/login');
  }
}