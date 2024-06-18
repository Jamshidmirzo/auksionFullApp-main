
import 'package:auksion_app/models/seller.dart';
import 'package:auksion_app/services/products_http_services.dart';

class ProductsRepository {
  final productsHttpServices = ProductsHttpServices();
  Future<List<Product>> getProducts() async {
    return productsHttpServices.getProducts();
  }

  Future<Product?> addProduct(
    String title,
    double price,
    String image,
  ) async {
    return productsHttpServices.addProduct(
      title,
      price,
      image,
    );
  }

  Future<void> editProduct(
    String id,
    String newTitle,
    double newPrice,
    String newImage,
  ) async {
    return productsHttpServices.editProduct(
      id,
      newTitle,
      newPrice,
      newImage,
    );
  }

  Future<void> deleteProduct(String id) async {
    return productsHttpServices.deleteProduct(id);
  }
}
