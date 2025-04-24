import 'package:ecommerce_getx_folderstructure/core/models/order_model.dart' show Order;
import 'package:ecommerce_getx_folderstructure/core/services/api_service.dart';
import 'package:get/get.dart';


class OrderController extends GetxController {
  final ApiService apiService = Get.find();
  var orders = <Order>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchOrders();
    super.onInit();
  }

  void fetchOrders() async {
    try {
      isLoading.value = true;
      final fetchedOrders = await apiService.getOrders();
      orders.assignAll(fetchedOrders);
    } catch (e) {
      Get.snackbar( e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}