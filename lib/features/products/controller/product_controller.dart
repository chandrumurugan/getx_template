import 'package:ecommerce_getx_folderstructure/core/models/product_model.dart';
import 'package:ecommerce_getx_folderstructure/core/services/api_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ApiService apiService = Get.find();
  var products = <Product>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading.value = true;
      final fetchedProducts = await apiService.getProducts();
      products.assignAll(fetchedProducts);
    } catch (e) {
      Get.snackbar( e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}