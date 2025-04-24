import 'package:ecommerce_getx_folderstructure/core/models/product_model.dart';
import 'package:ecommerce_getx_folderstructure/features/whishlist/controller/wishlist_controller.dart';
import 'package:ecommerce_getx_folderstructure/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../cart/controller/cart_controller.dart';


class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final Product prod = Product.fromMap(product);
    final CartController cartController = Get.find();
    final WishlistController wishlistController = Get.find();

    return Scaffold(
      appBar: AppBar(title: Text(prod.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              prod.imageUrl,
              height: 200,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
            ),
            const SizedBox(height: 16),
            Text(prod.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('\$${prod.price}', style: const TextStyle(fontSize: 20, color: Colors.green)),
            const SizedBox(height: 8),
            Text(prod.description),
            const Spacer(),
            Obx(() => IconButton(
                  icon: Icon(
                    wishlistController.isInWishlist(prod) ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () => wishlistController.toggleWishlist(prod),
                )),
            CustomButton(
              text: 'Add to Cart',
              onPressed: () => cartController.addToCart(prod, 1),
            ),
          ],
        ),
      ),
    );
  }
}