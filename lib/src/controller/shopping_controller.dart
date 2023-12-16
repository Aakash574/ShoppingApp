import 'package:get/state_manager.dart';
import 'package:shopping_app/src/data/remote/product_repository.dart';
import 'package:shopping_app/src/models/product_model.dart';

class ProductController extends GetxController {
  var productList = <Product>[].obs;

  @override
  void onInit() {
    getProductsList();
    super.onInit();
  }

  void getProductsList() async {
    var products = await ProductRepository().getProducts();
    productList.value = products;
  }
}
