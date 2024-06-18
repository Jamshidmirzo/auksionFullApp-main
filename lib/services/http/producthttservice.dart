import 'dart:convert';
import 'package:auksion_app/models/product.dart';
import 'package:http/http.dart' as http;

class ProductHttpService {
  List<Product> _productList = [];
  List<Product> _computercategory = [];
  List<Product> _housecategory = [];
  List<String> _allcategories = [];
  List<Product> _carcategory = [];

  Future<List<Product>> getProducts([int id = 0]) async {
    Uri url = Uri.parse(
        'https://examproject-6ab96-default-rtdb.firebaseio.com/categories.json');
    final response = await http.get(url);

    // Clear the lists
    _productList.clear();
    _computercategory.clear();
    _housecategory.clear();
    _carcategory.clear();
    _allcategories.clear();

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      data.forEach((key, value) {
        _allcategories.add(key);
        if (value is List) {
          value.forEach((productData) {
            final product = Product(
              categoryname: productData['categoryname'],
              auksiontime: productData['auksiontime'],
              name: productData['name'],
              categoryID: key,
              description: productData['description'],
              endprice: productData['endprice'],
              id: productData['id']?.toString() ??
                  DateTime.now().millisecondsSinceEpoch.toString(),
              images:
                  List<Map<String, dynamic>>.from(productData['images'] ?? []),
              rating: productData['rating'],
              startprice: productData['startprice'],
            );
            if (key == 'computer') {
              _computercategory.add(product);
            } else if (key == 'car') {
              _carcategory.add(product);
            }
            _productList.add(product);
          });
        } else if (key == 'uylar' && value is Map) {
          final images = List<Map<String, dynamic>>.from(value['images'] ?? []);
          value.forEach((houseKey, houseData) {
            if (houseKey != 'images') {
              final product = Product(
                categoryname: houseData['categoryname'],
                auksiontime: houseData['auksiontime'],
                name: houseData['name'],
                categoryID: key,
                description: houseData['description'],
                endprice: houseData['endprice'],
                id: houseKey,
                images: images,
                rating: houseData['rating'],
                startprice: houseData['startprice'],
              );
              _housecategory.add(product);
              _productList.add(product);
            }
          });
        }
      });

      if (!_allcategories.contains('all')) {
        _allcategories.insert(0, 'all');
      }
    } else {
      print('Failed to load products. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load products');
    }

    switch (id) {
      case 1:
        return _carcategory;
      case 2:
        return _computercategory;
      case 3:
        return _housecategory;
      default:
        return _productList;
    }
  }

  Future<List<String>> getAllCategories() async {
    if (_allcategories.isEmpty) {
      await getProducts();
    }
    return [..._allcategories];
  }

  Future<void> updateStartPrice(
      String productName, String category, int newStartPrice) async {
    bool productFound = false;
    for (var product in _productList) {
      if (product.name == productName && product.categoryID == category) {
        productFound = true;
        product.startprice = newStartPrice;
        print('Product ID: ${product.id}');

        Uri url = Uri.parse(
            'https://examproject-6ab96-default-rtdb.firebaseio.com/categories/$category/${product.id}.json');
        final response = await http.patch(
          url,
          body: jsonEncode({'startprice': newStartPrice}),
        );

        if (response.statusCode != 200) {
          print(
              'Failed to update startprice. Status code: ${response.statusCode}');
          print('Response body: ${response.body}');
          throw Exception('Failed to update startprice');
        }
        break;
      }
    }

    if (!productFound) {
      print('Product not found: $productName in category $category');
      throw Exception('Product not found');
    }
  }
}
