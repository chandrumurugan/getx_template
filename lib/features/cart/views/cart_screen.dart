import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Obx(() => controller.cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = controller.cartItems[index];
                      return ListTile(
                        leading: Image.network(
                          item.product.imageUrl,
                          width: 50,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                        ),
                        title: Text(item.product.name),
                        subtitle: Text('Quantity: ${item.quantity}'),
                        trailing: Text('\$${item.product.price * item.quantity}'),
                        onLongPress: () => controller.removeFromCart(item.product.id),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total: \$${controller.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )));
 
  }
}