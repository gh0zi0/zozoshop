import 'package:get/get.dart';

class Cart extends GetxController {
  final String? id;
  final String? title;
  final double price;

  Cart({
    this.title,
    required this.price,
    this.id,
  });

  Map<String, Cart> items = {};

  double get totalAmount {
    var total = 0.0;
    items.forEach((key, cartItem) {
      total += cartItem.price;
    });
    return total;
  }

  Future<void> addItem(
    double price,
    String title,
  ) async {
    items.putIfAbsent(
      DateTime.now().toString(),
      () => Cart(
        id: DateTime.now().toString(),
        title: title,
        price: price,
      ),
    );
  }
  Future<void> clear() async {
    items = {};
  }
}
