import 'package:get_storage/get_storage.dart';

class StorageService {
  final _box = GetStorage();

  // Save user token
  void saveUserToken(String token) {
    _box.write('user_token', token);
  }

  // Get user token
  String? getUserToken() {
    return _box.read('user_token');
  }

  // Remove user token
  void removeUserToken() {
    _box.remove('user_token');
  }

  // Save wishlist
  void saveWishlist(List<String> wishlist) {
    _box.write('wishlist', wishlist);
  }

  // Get wishlist
  List<String> getWishlist() {
    return List<String>.from(_box.read('wishlist') ?? []);
  }

  // Save cart
  void saveCart(List<Map<String, dynamic>> cart) {
    _box.write('cart', cart);
  }

  // Get cart
  List<Map<String, dynamic>> getCart() {
    return List<Map<String, dynamic>>.from(_box.read('cart') ?? []);
  }
}