import 'package:auksion_app/models/product.dart';
import 'package:auksion_app/services/http/producthttservice.dart';

class ProductController {
  List<Product> _productList = [];
  List<Product> _computerCategory = [];
  List<Product> _houseCategory = [];
  List<String> _allCategories = [];
  List<Product> _carCategory = [];
  final ProductHttpService productHttpService = ProductHttpService();

  Future<List<Product>> getProduct([int id = 0]) async {
    try {
      List<Product> products = await productHttpService.getProducts();
      _productList.clear();
      _computerCategory.clear();
      _houseCategory.clear();
      _carCategory.clear();
      _allCategories.clear();

      for (var product in products) {
        _productList.add(product);

        switch (product.categoryID) {
          case 'computer':
            _computerCategory.add(product);
            break;
          case 'car':
            _carCategory.add(product);
            break;
          case 'uylar':
            _houseCategory.add(product);
            break;
        }

        if (!_allCategories.contains(product.categoryID)) {
          _allCategories.add(product.categoryID);
        }
      }

      if (!_allCategories.contains('all')) {
        _allCategories.insert(0, 'all');
      }

      switch (id) {
        case 0:
          return _productList;
        case 1:
          return _carCategory;
        case 2:
          return _computerCategory;
        case 3:
          return _houseCategory;
        default:
          return _productList;
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<List<String>> getCategories() async {
    if (_allCategories.isEmpty) {
      await getProduct();
    }
    return _allCategories;
  }

  Future<void> updatePrice(
      int newPrice, String productName, String category) async {
    await productHttpService.getProducts();
    await productHttpService.updateStartPrice(productName, category, newPrice);
  }
}
