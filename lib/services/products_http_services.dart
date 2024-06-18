import 'dart:convert';
import 'package:auksion_app/models/seller.dart';
import 'package:http/http.dart' as http;


class ProductsHttpServices {
  Future<List<Product>> getProducts() async {
    Uri url = Uri.parse(
        "https://fir-73d12-default-rtdb.firebaseio.com/products.json");

    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<Product> loadedProducts = [];
    if (data != null) {
      data.forEach((key, value) {
        value['id'] = key;
        loadedProducts.add(Product.fromJson(value));
      });
    }

    return loadedProducts;
  }

  Future<Product?> addProduct(
    String title,
    double price,
    String image,
  ) async {
    Uri url = Uri.parse(
        "https://fir-73d12-default-rtdb.firebaseio.com/products.json");

    Map<String, dynamic> productData = {
      "title": title,
      "price": price,
      "image": image,
    };
    final response = await http.post(
      url,
      body: jsonEncode(productData),
    );
    final data = jsonDecode(response.body);
    if (data != null) {
      productData['id'] = data['name'];
      Product newProduct = Product.fromJson(productData);
      return newProduct;
    }

    return null;
  }

  Future<void> editProduct(
    String id,
    String newTitle,
    double newPrice,
    String newImage,
  ) async {
    Uri url = Uri.parse(
        "https://fir-73d12-default-rtdb.firebaseio.com/products/$id.json");

    Map<String, dynamic> productData = {
      "title": newTitle,
      "price": newPrice,
      "image": newImage,
    };
    await http.patch(
      url,
      body: jsonEncode(productData),
    );
  }

  Future<void> deleteProduct(String id) async {
    Uri url = Uri.parse(
        "https://fir-73d12-default-rtdb.firebaseio.com/products/$id.json");

    await http.delete(url);
  }
}