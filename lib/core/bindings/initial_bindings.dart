import 'package:ecommerce_getx_folderstructure/core/services/connectivity_service.dart';
import 'package:get/get.dart';
import '../../features/auth/controller/auth_controller.dart';
import '../../features/cart/controller/cart_controller.dart';
import '../../features/products/controller/product_controller.dart';
import '../../features/orders/controller/order_controller.dart';
import '../../features/whishlist/controller/wishlist_controller.dart' show WishlistController;
import '../services/api_service.dart';
import '../storage/storage_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConnectivityService());
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => StorageService());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => ProductController());
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => OrderController());
    Get.lazyPut(() => WishlistController());
  }
}