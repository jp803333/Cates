
import 'package:cates/Models/Core/Customer.dart';
import 'package:cates/Models/Core/Review.dart';
import 'package:flutter/cupertino.dart';
import 'FoodItem.dart';

class Caterer {
  String id;
  String photo;
  String name;
  String email;
  Address address;
  double rating;
  String mobile;
  List<Review> reviews;
  List<FoodItem> foodItems;
  Caterer({
    @required this.id,
    @required this.photo,
    @required this.name,
    @required this.email,
    @required this.address,
    @required this.mobile,
    @required this.reviews,
    @required this.foodItems,
    @required this.rating,
  });

  Caterer.fromMap(Map snapshot, String id) {
    id = id ?? " ";
    name = snapshot['name'];
    email = snapshot['email'];
    mobile = snapshot['number'];
    photo = snapshot['photo'];
    rating = snapshot['rating'];
    foodItems =
        (snapshot['items'] as List).map((i) => FoodItem.fromMap(i)).toList();
    reviews =
        (snapshot['reviews'] as List).map((i) => Review.fromMap(i)).toList();
    address = Address(
      line1: snapshot['address']['line1'],
      line2: snapshot['address']['line2'],
      state: snapshot['address']['state'],
      city: snapshot['address']['city'],
    );
  }
}
