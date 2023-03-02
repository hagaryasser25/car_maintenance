import 'package:flutter/cupertino.dart';

class Cars {
  Cars({
    String? id,
    String? name,
    String? capacity,
    String? color,
    String? imageUrl,
    String? model,
    String? price,
    String? galleryName,
  }) {
    _id = id;
    _name = name;
    _capacity = capacity;
    _color = color;
    _imageUrl = imageUrl;
    _model = model;
    _price = price;
    _galleryName = galleryName;
  }

  Cars.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _color = json['color'];
    _capacity = json['capacity'];
    _imageUrl = json['imageUrl'];
    _model = json['model'];
    _price = json['price'];
    _galleryName = json['galleryName'];
  }

  String? _id;
  String? _name;
  String? _color;
  String? _capacity;
  String? _imageUrl;
  String? _model;
  String? _price;
  String? _galleryName;

  String? get id => _id;
  String? get name => _name;
  String? get color => _color;
  String? get capacity => _capacity;
  String? get imageUrl => _imageUrl;
  String? get model => _model;
  String? get price => _price;
  String? get galleryName => _galleryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['color'] = _color;
    map['capacity'] = _capacity;
    map['imageUrl'] = _imageUrl;
    map['model'] = _model;
    map['price'] = _price;
    map['galleryName'] = _galleryName;

    return map;
  }
}
