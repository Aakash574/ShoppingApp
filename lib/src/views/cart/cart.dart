import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shopping_app/src/controller/cart_controller.dart';
import 'package:shopping_app/src/models/product_model.dart';

class Cart extends StatelessWidget {
  Cart({super.key});
  final CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 96,
        title: Text(
          "Your Cart",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => ListView.builder(
            itemCount: _cartController.cartList.length,
            itemBuilder: (BuildContext context, int index) {
              return CartList(
                cartProductList: _cartController.cartList[index],
                controller: _cartController,
                index: index,
              );
            },
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   color: Colors.transparent,
      //   height: 100,
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: size.width - 100,
        height: 64,
        margin: const EdgeInsets.all(24),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color.fromARGB(255, 255, 100, 89),
          child: GetBuilder<CartController>(
            init: CartController(),
            initState: (_) {},
            builder: (_) {
              return Text(
                "Cackout Now - \$ ${_cartController.totalPrice.toString()}",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CartList extends StatelessWidget {
  const CartList({
    super.key,
    required this.cartProductList,
    required this.controller,
    required this.index,
  });

  final Product cartProductList;
  final CartController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 230,
      margin: EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
          bottom: (index + 1) == controller.cartList.length ? 120 : 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(2, 2),
            blurRadius: 2,
            spreadRadius: 2,
          )
        ],
      ),
      child: Row(
        children: [
          Column(
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: cartProductList.thumbnail.toString(),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      controller.itemRemoveCount(
                          cartProductList, controller.cartList[index].id);
                    },
                    padding: EdgeInsets.zero,
                    icon: const FaIcon(
                      FontAwesomeIcons.minus,
                      size: 16,
                    ),
                  ),
                  Container(
                    height: 32,
                    width: 48,
                    margin: const EdgeInsets.all(12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.black54),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: GetBuilder<CartController>(
                      builder: (_) {
                        return Text(_.cartList[index].count.toString());
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.itemAddCount(cartProductList);
                      controller.updateTotalPrice();
                    },
                    padding: EdgeInsets.zero,
                    icon: const FaIcon(
                      FontAwesomeIcons.plus,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: size.width / 2.8,
                child: Text(
                  cartProductList.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: Colors.yellow.shade600,
                    size: 24,
                  ),
                  Text(
                    cartProductList.rating.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                "\$${cartProductList.price}.00",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              // const Spacer(),
              SizedBox(
                height: 36,
                width: 100,
                child: FloatingActionButton(
                  backgroundColor: Colors.grey,
                  onPressed: () => controller.removeToCart(cartProductList.id),
                  child: const FaIcon(
                    FontAwesomeIcons.trash,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
