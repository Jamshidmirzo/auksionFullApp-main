
import 'package:auksion_app/models/seller.dart';
import 'package:auksion_app/repositories/products_repository.dart';

class ProductsViewmodel {
  final productsRepository = ProductsRepository();
  List<Product> _list = [
    Product(
      id: "1",
      title: "iPhone 11",
      price: 200,
      image:
          "https://www.apple.com/newsroom/images/product/iphone/standard/Apple_iphone_11-rosette-family-lineup-091019_big.jpg.large.jpg",
    ),
  ];

  Future<List<Product>> get list async {
    _list = await productsRepository.getProducts();
    return [..._list];
  }

  Future<void> addProduct(
    String title,
    double price,
    String image,
  ) async {
    final newProduct = await productsRepository.addProduct(
      title,
      price,
      image,
    );
    if (newProduct != null) {
      _list.add(newProduct);
    }
  }

  Future<void> editProduct(
    String id,
    String newTitle,
    double newPrice,
    String newImage,
  ) async {
    await productsRepository.editProduct(
        id, newTitle, newPrice, newImage);
    final index = _list.indexWhere((product) {
      return product.id == id;
    });
    _list[index].title = newTitle;
    _list[index].price = newPrice;
    _list[index].image = newImage;
  }

  void deleteProduct(String id) async {
    _list.removeWhere((product) {
      return product.id == id;
    });
    productsRepository.deleteProduct(id);
  }
}
