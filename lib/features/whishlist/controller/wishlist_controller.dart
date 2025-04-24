import 'package:ecommerce_getx_folderstructure/core/models/product_model.dart';
import 'package:ecommerce_getx_folderstructure/core/storage/storage_service.dart';
import 'package:ecommerce_getx_folderstructure/features/products/controller/product_controller.dart';
import 'package:get/get.dart';


class WishlistController extends GetxController {
  final StorageService storageService = Get.find();
  var wishlist = <Product>[].obs;

  @override
  void onInit() {
    loadWishlist();
    super.onInit();
  }

  void loadWishlist() {
    final wishlistIds = storageService.getWishlist();
    final productController = Get.find<ProductController>();
    wishlist.assignAll(
      productController.products.where((p) => wishlistIds.contains(p.id)).toList(),
    );
  }

  void toggleWishlist(Product product) {
    if (wishlist.contains(product)) {
      wishlist.remove(product);
    } else {
      wishlist.add(product);
    }
    storageService.saveWishlist(wishlist.map((p) => p.id).toList());
  }

  bool isInWishlist(Product product) => wishlist.contains(product);
}