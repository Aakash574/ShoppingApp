// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/src/controller/cart_controller.dart';
import 'package:shopping_app/src/controller/shopping_controller.dart';
import 'package:shopping_app/src/views/cart/cart.dart';
import 'package:shopping_app/src/views/dashboard/dashboard.dart';

class ShoppingApp extends StatefulWidget {
  const ShoppingApp({super.key});

  @override
  State<ShoppingApp> createState() => _ShoppingAppState();
}

class _ShoppingAppState extends State<ShoppingApp> {
  final ProductController _productController = Get.put(ProductController());
  final CartController _cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 128,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              'Shopping',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Spacer(),
            GetX<CartController>(
              init: CartController(),
              initState: (_) {},
              builder: (_) {
                return Text(
                  "Total cart price \$${_.totalPrice}",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.black),
                );
              },
            )
          ],
        ),
      ),
      body: Dashboard(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => Cart()),
        label: GetX<CartController>(
          initState: (_) {},
          builder: (controller) {
            return Text(
              controller.itemInCart.toString(),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.black,
                  ),
            );
          },
        ),
        icon: const Icon(Icons.shopping_basket),
      ),
    );
  }
}
