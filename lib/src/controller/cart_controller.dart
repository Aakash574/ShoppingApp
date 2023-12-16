import 'dart:developer';

import 'package:get/state_manager.dart';
import 'package:shopping_app/src/models/product_model.dart';

class CartController extends GetxController {
  var cartList = <Product>[].obs;

  double get totalPrice => cartList.fold(0, (total, element) {
        if (element.count == 1) {
          return total + element.price;
        } else {
          return total + (element.price * element.count);
        }
      });

  int get itemInCart => cartList.length;

  void updateTotalPrice() {
    update();
  }

  void addToCart(Product cartItem) {
    cartList.add(cartItem);
  }

  void removeToCart(int id) {
    cartList.removeWhere((item) => item.id == id);
  }

  void itemAddCount(Product product) {
    int index = cartList.indexOf(product);
    cartList[index].count += 1;
    update();
  }

  void itemRemoveCount(Product product, int id) {
    int index = cartList.indexOf(product);
    if (cartList[index].count == 1) {
      cartList.removeWhere((item) => item.id == id);
    } else {
      cartList[index].count -= 1;
    }
    update();
  }
}
