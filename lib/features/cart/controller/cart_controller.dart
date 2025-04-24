import 'package:ecommerce_getx_folderstructure/core/models/cart_model.dart';
import 'package:ecommerce_getx_folderstructure/core/models/product_model.dart';
import 'package:ecommerce_getx_folderstructure/core/services/api_service.dart';
import 'package:ecommerce_getx_folderstructure/core/storage/storage_service.dart';
import 'package:get/get.dart';


class CartController extends GetxController {
  final ApiService apiService = Get.find();
  final StorageService storageService = Get.find();
  var cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    loadCart();
    super.onInit();
  }

  void loadCart() {
    final cartData = storageService.getCart();
    cartItems.assignAll(cartData.map((e) => CartItem.fromMap(e)).toList());
  }

  void addToCart(Product product, int quantity) async {
    try {
      // Optionally sync with server
      await apiService.addToCart(product.id, quantity);
      final existingItem = cartItems.firstWhereOrNull(
        (item) => item.product.id == product.id,
      );
      if (existingItem != null) {
        existingItem.quantity += quantity;
      } else {
        cartItems.add(CartItem(product: product, quantity: quantity));
      }
      cartItems.refresh();
      storageService.saveCart(cartItems.map((e) => e.toMap()).toList());
      Get.snackbar( 'Added to cart');
    } catch (e) {
      Get.snackbar( e.toString());
    }
  }

  void removeFromCart(String productId) {
    cartItems.removeWhere((item) => item.product.id == productId);
    storageService.saveCart(cartItems.map((e) => e.toMap()).toList());
  }

  double get totalPrice => cartItems.fold(
        0,
        (sum, item) => sum + (item.product.price * item.quantity),
      );
}