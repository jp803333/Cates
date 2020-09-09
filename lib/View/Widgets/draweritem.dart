import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

class DrawerItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function function;
  const DrawerItem(
      {Key key,
      @required this.name,
      @required this.icon,
      @required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        highlightColor: primaryColorLight,
        splashColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Icon(this.icon, color: primaryColor),
              SizedBox(
                width: 10,
              ),
              Text(
                this.name,
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              )
            ],
          ),
        ),
        onTap: this.function,
      ),
    );
  }
}
