class Order {
  final String id;
  final DateTime date;
  final double total;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.date,
    required this.total,
    required this.items,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      date: DateTime.parse(map['date']),
      total: map['total'].toDouble(),
      items: (map['items'] as List)
          .map((e) => OrderItem.fromMap(e))
          .toList(),
    );
  }
}

class OrderItem {
  final String productId;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['productId'],
      quantity: map['quantity'],
      price: map['price'].toDouble(),
    );
  }
}