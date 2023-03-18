import 'package:flutter/cupertino.dart';

class Booking {
  Booking({
    String? id,
    String? galleryName,
    String? address,
    String? carName,
    String? phoneNumber,
    String? name,
    String? price,
    String? color,
    String? date,
    String? nationalId,
  }) {
    _id = id;
    _galleryName = galleryName;
    _address = address;
    _carName = carName;
    _phoneNumber = phoneNumber;
    _name = name;
    _price = price;
    _color = color;
    _date = date;
    _nationalId = nationalId;
  }

  Booking.fromJson(dynamic json) {
    _id = json['id'];
    _galleryName = json['galleryName'];
    _carName = json['carName'];
    _address = json['address'];
    _phoneNumber = json['phoneNumber'];
    _name = json['name'];
    _price = json['price'];
    _color = json['color'];
    _date = json['date'];
    _nationalId = json['nationalId'];
  }

  String? _id;
  String? _galleryName;
  String? _carName;
  String? _address;
  String? _phoneNumber;
  String? _name;
  String? _price;
  String? _color;
  String? _date;
  String? _nationalId;

  String? get id => _id;
  String? get galleryName => _galleryName;
  String? get carName => _carName;
  String? get address => _address;
  String? get phoneNumber => _phoneNumber;
  String? get name => _name;
  String? get price => _price;
  String? get color => _color;
  String? get date => _date;
  String? get nationalId => _nationalId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['galleryName'] = _galleryName;
    map['carName'] = _carName;
    map['address'] = _address;
    map['phoneNumber'] = _phoneNumber;
    map['name'] = _name;
    map['price'] = _price;
    map['color'] = _color;
    map['date'] = _date;
    map['nationalId'] = _nationalId;

    return map;
  }
}
