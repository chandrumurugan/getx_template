import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_buttons.dart';
import '../controller/auth_controller.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        text: 'Login',
                        onPressed: () => controller.login(
                          emailController.text,
                          passwordController.text,
                          context,
                        ),
                      ),
              ],
            )),
      ),
    );
  }
}