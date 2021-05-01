import 'package:cates/Models/Core/Caterer.dart';
import 'package:cates/Provider/providers.dart';
import 'package:cates/View/Widgets/CatererTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookMarkedCaterersPage extends StatefulWidget {
  @override
  _BookMarkedCaterersPageState createState() => _BookMarkedCaterersPageState();
}

class _BookMarkedCaterersPageState extends State<BookMarkedCaterersPage> {
  List<dynamic> _bookMarkedCaterers;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
          ),
          body: Center(
            child: StreamBuilder(
              stream: CatererProvider().getBookMarkedCaterer(value.user.uid),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.data == null) {
                  return CircularProgressIndicator();
                } else {
                  _bookMarkedCaterers =
                      List.from(snapshot.data.data()['bookmarked']);
                  if (_bookMarkedCaterers == null) {
                    return CircularProgressIndicator();
                  } else if (_bookMarkedCaterers.length == 0) {
                    return Text('No book marked Cateres');
                  } else {
                    return ListView.builder(
                      itemCount: _bookMarkedCaterers.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder(
                          future: CatererProvider().getSingleCaterer(
                              _bookMarkedCaterers[index].toString()),
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.exists) {
                                Caterer _caterer = Caterer.fromMap(
                                    snapshot.data.data(),
                                    _bookMarkedCaterers[index].toString());
                                return catererTile(context, _caterer);
                              } else {
                                return Text("missing caterer");
                              }
                            } else {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.45,
                                    vertical: 20),
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        );
      },
    );
  }
}
