import 'package:Cates/Provider/AuthProvider.dart';
import 'package:Cates/View/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'draweritem.dart';

class CustomDarwer extends StatefulWidget {
  @override
  _CustomDarwerState createState() => _CustomDarwerState();
}

class _CustomDarwerState extends State<CustomDarwer> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(25)),
      child: Drawer(
        child: Container(
          child: Column(
            children: [
              DrawerHeader(),
              SizedBox(
                height: 10,
              ),
              DrawerItem(
                icon: Icons.home,
                name: 'Home',
                function: () {
                  print('clicked home');
                },
              ),
              DrawerItem(
                icon: Icons.account_balance_wallet,
                name: 'Subscription',
                function: () {
                  print('clicked subscriptions');
                },
              ),
              Expanded(child: SizedBox()),
              DrawerItem(
                icon: Icons.settings,
                name: 'Settings',
                function: () {
                  print('clicked settings');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerHeader extends StatefulWidget {
  @override
  _DrawerHeaderState createState() => _DrawerHeaderState();
}

class _DrawerHeaderState extends State<DrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      return Container(
        child: SizedBox(
          width: double.infinity,
          height: 150,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  // 'User Name',
                  authProvider.user.name,
                  style: GoogleFonts.lato(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [primaryColorDark, primaryColorLight],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
      );
    });
  }
}
