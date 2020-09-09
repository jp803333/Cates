import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DataOpsApi {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference _ref;
  DataOpsApi({@required collection}){
    _ref = db.collection(collection);
  }
  Stream<QuerySnapshot> streamDataCollection(){
    return _ref.snapshots();
  }
}
