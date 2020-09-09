import 'package:Cates/Models/Core/Customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum AuthStatus { authenticating, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  Customer _user;

  Customer get user => _user;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Customer> _createFromUid(String uid, String name, String email,
      String phone, Map<String, dynamic> address) {
    FirebaseFirestore.instance.collection('Users').doc(uid).set({
      "email": email,
      "name": name,
      "phone": phone,
      "address": {
        "city": address['city'],
        "line1": address['line1'],
        "line2": address['line2'],
        "state": address['state'],
      }
    }).then((_) {
      return Customer(
          uid: uid,
          name: name,
          email: email,
          mobile: phone,
          address: new Address(
            city: address['city'],
            line1: address['line1'],
            line2: address['line2'],
            state: address['state'],
          ));
    }).catchError((e) {
      print(e);
      throw e;
    });
    return null;
  }

  Future<Customer> _getFromUid(String uid) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    return Customer(
        uid: uid,
        name: snapshot.get('name'),
        email: snapshot.get('email'),
        mobile: snapshot.get('phone'),
        address: new Address(
            city: snapshot.get('address')['city'],
            line1: snapshot.get('address')['line1'],
            line2: snapshot.get('address')['line2'],
            state: snapshot.get('address')['state']));
  }

  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser == null) {
      return false;
    } else {
      _getFromUid(FirebaseAuth.instance.currentUser.uid).then((value) {
        _user = value;
      });
      return true;
    }
  }

  void logInWithEmailAndPassword({@required email, @required password}) async {
    _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      try {
        _user = await _getFromUid(value.user.uid);
        notifyListeners();
      } catch (e) {
        print(e);
        throw e;
      }
    }).catchError((e) {
      throw e;
    });
    return null;
  }

  Future<Customer> signUpWithEmailandPassword(
      {@required email,
      @required password,
      @required name,
      @required phone,
      @required address}) {
    _firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) async {
      try {
        _user = await _createFromUid(
          value.user.uid,
          name,
          email,
          phone,
          address,
        );
        notifyListeners();
      } catch (e) {
        print(e);
        throw e;
      }
    }).catchError((e) {
      print(e);
      throw e;
    });
    return null;
  }

  signout() {
    _firebaseAuth.signOut().then((value) {
      _user = null;
      notifyListeners();
    }).catchError((e) {
      print(e);
      throw e;
    });
  }

}
