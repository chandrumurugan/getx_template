import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/order_controller.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController controller = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : controller.orders.isEmpty
              ? const Center(child: Text('No orders yet'))
              : ListView.builder(
                  itemCount: controller.orders.length,
                  itemBuilder: (context, index) {
                    final order = controller.orders[index];
                    return ListTile(
                      title: Text('Order #${order.id}'),
                      subtitle: Text('Date: ${order.date.toString().split(' ')[0]}'),
                      trailing: Text('\$${order.total}'),
                    );
                  },
                )),
    );
  }
}