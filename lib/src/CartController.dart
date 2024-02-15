import 'package:get/get.dart';
import 'cart.dart' as cart;

class CartController extends GetxController {
  List<cart.CartItem> cartItems = [];

  void addToCart(cart.CartItem item) {
    cartItems.add(item);
  }

  void removeFromCart(cart.CartItem item) {
    cartItems.remove(item);
  }
}
