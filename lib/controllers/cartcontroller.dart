import 'package:auksion_app/models/product.dart';
import 'package:auksion_app/services/http/carthhtpservice.dart';

class CartController {
  final CartHttpService cartHttpService = CartHttpService();

  Future<void> addToCart(Product product) {
    return cartHttpService.addToCart(product);
  }

  Future<List<Product>> getProductsBySellerID() {
    return cartHttpService.getProductsBySellerID();
  }
}
