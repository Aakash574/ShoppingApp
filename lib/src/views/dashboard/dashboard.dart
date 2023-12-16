import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/src/controller/shopping_controller.dart';
import 'package:shopping_app/src/utils/widgets/product_card.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  final ProductController _productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Obx(
              () => StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                itemCount: _productController.productList.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: _productController.productList[index],
                  );
                },
                staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
