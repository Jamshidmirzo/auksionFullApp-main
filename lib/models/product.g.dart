// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      auksiontime: json['auksiontime'] as String,
      name: json['name'] as String,
      categoryID: json['categoryID'] as String,
      description: json['description'] as String,
      endprice: (json['endprice'] as num).toInt(),
      id: json['id'] as String,
      images: json['images'] as List<dynamic>,
      rating: (json['rating'] as num).toInt(),
      startprice: (json['startprice'] as num).toInt(),
      categoryname: json['categoryname'] as String,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'images': instance.images,
      'categoryID': instance.categoryID,
      'description': instance.description,
      'startprice': instance.startprice,
      'endprice': instance.endprice,
      'rating': instance.rating,
      'auksiontime': instance.auksiontime,
      'categoryname': instance.categoryname,
    };
