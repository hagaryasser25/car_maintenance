import 'package:flutter/cupertino.dart';

class Gallery {
  Gallery({
    String? id,
    String? name,
    String? phoneNumber,
    String? imageUrl,
  }) {
    _id = id;
    _name = name;
    _phoneNumber = phoneNumber;
    _imageUrl = imageUrl;
  }

  Gallery.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _phoneNumber = json['phoneNumber'];
    _imageUrl = json['imageUrl'];
  }

  String? _id;
  String? _name;
  String? _phoneNumber;
  String? _imageUrl;

  String? get id => _id;
  String? get name => _name;
  String? get phoneNumber => _phoneNumber;
  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['phoneNumber'] = _phoneNumber;
    map['imageUrl'] = _imageUrl;


    return map;
  }
}