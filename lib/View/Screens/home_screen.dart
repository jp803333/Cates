import 'package:cates/Models/Core/Caterer.dart';
import 'package:cates/Provider/providers.dart';
import 'package:cates/View/Widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Scaffold(
            drawer: CustomDarwer(),
            appBar: AppBar(
              centerTitle: true,
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              title: Container(
                child: Text(
                  'CATES',
                  style: GoogleFonts.lato(
                    fontSize: 30.0,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () {
                    authProvider.signout();
                  },
                ),
              ],
            ),
            body: Consumer<CatererProvider>(
              builder: (context, catererProvider, child) {
                return StreamBuilder(
                  stream: catererProvider.getCaterersAsStream(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      List<Caterer> caterers = snapshot.data.docs
                          .map((doc) => Caterer.fromMap(doc.data(), doc.id))
                          .toList();
                      return ListView.builder(
                        // itemCount: caterers.length,
                        itemCount: 10,
                        itemBuilder: (BuildContext context, index) =>
                            catererTile(
                          context,
                          caterers[0],
                        ),
                      );
                    }
                  },
                );
              },
            ));
      },
    );
  }
}
