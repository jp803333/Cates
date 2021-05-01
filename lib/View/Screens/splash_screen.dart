import 'package:cates/Provider/AuthProvider.dart';
import 'screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (!authProvider.isLoggedIn()) {
          return Login();
        } else {
          return HomeScreen();
        }
      },
    );
  }
}

Widget splash(BuildContext context) {
  return Stack(
    fit: StackFit.expand,
    children: [
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'CATES',
            style: GoogleFonts.lato(
              fontSize: 50.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      )
    ],
  );
}
