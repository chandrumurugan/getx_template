import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../controller/product_controller.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => context.go('/wishlist'),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => context.go('/cart'),
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => context.go('/orders'),
          ),
        ],
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: controller.products.length,
              itemBuilder: (context, index) {
                final product = controller.products[index];
                return ListTile(
                  leading: Image.network(
                    product.imageUrl,
                    width: 50,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                  ),
                  title: Text(product.name),
                  subtitle: Text('\$${product.price}'),
                  onTap: () => context.go(
                    '/product/${product.id}',
                    extra: product.toMap(),
                  ),
                );
              },
            )),
    );
  }
}