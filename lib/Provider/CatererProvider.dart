import 'package:Cates/Models/Services/DataOpsApi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CatererProvider extends ChangeNotifier {
  // List<Caterer> _caterers;
  DataOpsApi _dataOpsApi = DataOpsApi(collection: 'Caterers');
  Stream<QuerySnapshot> getCaterersAsStream() {
    return _dataOpsApi.streamDataCollection();
  }

  Stream<DocumentSnapshot> getBookMarkedCaterer(String userId) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .snapshots();
  }

  Future<DocumentSnapshot> getSingleCaterer(String catererId) {
    return FirebaseFirestore.instance
        .collection('Caterers')
        .doc(catererId)
        .get();
    // .snapshots();
  }

  void bookMarkACaterer(String userId, List<String> catererId) {
    FirebaseFirestore.instance.collection("user").doc(userId).update(
      {"bookmarked": FieldValue.arrayUnion(catererId)},
    );
  }

  void unBookMarkACaterer(String userId, List<String> catererId) {
    FirebaseFirestore.instance.collection("user").doc(userId).update(
      {"bookmarked": FieldValue.arrayRemove(catererId)},
    );
  }
  // void unMarkACatere(String userId,)
}
