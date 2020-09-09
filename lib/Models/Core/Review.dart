import 'package:flutter/material.dart';

class Review {
  String username;
  double rating;
  String msg;
  Review({
    @required this.username,
    @required this.msg,
    @required this.rating,
  });

  Review.fromMap(Map map){
    username = map['username'];
    rating = map['rating'];
    msg = map['msg'];
  }
}
