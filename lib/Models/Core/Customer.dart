import 'package:flutter/material.dart';

class Address {
  final String line1;
  final String line2;
  final String state;
  final String city;

  Address({
    @required this.line1,
    @required this.line2,
    @required this.state,
    @required this.city,
  });
}

class Customer {
  final String uid;
  final String name;
  final String email;
  final String mobile;
  final Address address;
  const Customer({
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.mobile,
    @required this.address,
  });
}
