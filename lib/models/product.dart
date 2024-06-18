import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable()
class Product {
  String id;
  String name;
  List images;
  String categoryID;
  String description;
  int startprice;
  int endprice;
  int rating;
  String auksiontime;
  String categoryname;
  Product({
    required this.auksiontime,
    required this.name,
    required this.categoryID,
    required this.description,
    required this.endprice,
    required this.id,
    required this.images,
    required this.rating,
    required this.startprice,
    required this.categoryname
  });
  factory Product.fromJsoon(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }
  Map<String, dynamic> toJson() {
    return _$ProductToJson(this);
  }
}
