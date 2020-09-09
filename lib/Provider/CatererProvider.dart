// import 'package:Cates/Models/Core/Caterer.dart';
import 'package:Cates/Models/Services/DataOpsApi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CatererProvider extends ChangeNotifier {
  // List<Caterer> _caterers;
  DataOpsApi _dataOpsApi = DataOpsApi(collection: 'Caterers');
  Stream<QuerySnapshot> getCaterersAsStream() {
    return _dataOpsApi.streamDataCollection();
  }
}
