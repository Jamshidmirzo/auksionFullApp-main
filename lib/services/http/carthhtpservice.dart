import 'dart:convert';
import 'package:auksion_app/models/product.dart';
import 'package:auksion_app/models/cart.dart';
import 'package:auksion_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartHttpService {
  Future<void> addToCart(Product product) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString("userData");
    final user = User.fromMap(jsonDecode(data!));
    String cartID = UniqueKey().toString(); // Generate a unique cart ID
    Cart cart = Cart(id: cartID, product: product, sellerID: user.id);
    Uri url = Uri.parse(
        'https://cartexam-8c291-default-rtdb.firebaseio.com/cart/.json');
    final response = await http.post(url, body: jsonEncode(cart.toMap()));

    if (response.statusCode != 200) {
      throw Exception('Failed to add to cart');
    }
  }

  // Method to fetch products by sellerID
  Future<List<Product>> getProductsBySellerID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? data1 = sharedPreferences.getString("userData");
    final user = User.fromMap(jsonDecode(data1!));
    Uri url = Uri.parse(
        'https://cartexam-8c291-default-rtdb.firebaseio.com/cart.json?orderBy="sellerID"&equalTo="${user.id}"');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch products');
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    List<Product> products = [];

    data.forEach((key, value) {
      Product product = Product.fromJsoon(value['product']);
      products.add(product);
    });

    return products;
  }
}
