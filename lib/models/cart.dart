import 'package:auksion_app/models/product.dart';

class Cart {
  String id;
  final String sellerID;
  final Product product;

  Cart({required this.product, required this.sellerID,required this.id});

  Map<String, dynamic> toMap() {
    return {
      'sellerID': sellerID,
      'product': product.toJson(),
    };
  }
}
