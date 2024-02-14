// ignore_for_file: file_names

import 'package:get/get.dart';

class CartController extends GetxController {
  RxList<String> cartItems = <String>[].obs;

  void addToCart(String item) {
    cartItems.add(item);
  }

  void removeFromCart(String item) {
    cartItems.remove(item);
  }
}
