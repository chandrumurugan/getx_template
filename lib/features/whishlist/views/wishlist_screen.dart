import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../controller/wishlist_controller.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WishlistController controller = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: Obx(() => controller.wishlist.isEmpty
          ? const Center(child: Text('Your wishlist is empty'))
          : ListView.builder(
              itemCount: controller.wishlist.length,
              itemBuilder: (context, index) {
                final product = controller.wishlist[index];
                return ListTile(
                  leading: Image.network(
                    product.imageUrl,
                    width: 50,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                  ),
                  title: Text(product.name),
                  subtitle: Text('\$${product.price}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => controller.toggleWishlist(product),
                  ),
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