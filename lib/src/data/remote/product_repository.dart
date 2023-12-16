import 'dart:convert';

import 'package:dio/dio.dart';
// import 'package:http/http.dart';
// import 'package:http/http.dart' as http;
import 'package:shopping_app/src/models/product_model.dart';

class ProductRepository {
  final Dio _dio = Dio();
  Future<List<Product>> getProducts() async {
    try {
      Response response = await _dio.get("https://dummyjson.com/products");
      if (response.statusCode == 200) {
        var jsonData = jsonEncode(response.data['products']);
        return productFromJson(jsonData.toString());
      } else {
        throw Exception("Error Occureed ::: ");
      }
    } catch (e) {
      throw Exception("Error By Getting products :: $e");
    }
  }
}
