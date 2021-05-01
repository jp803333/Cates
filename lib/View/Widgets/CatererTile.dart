import 'package:cates/Models/Core/Caterer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Fluid_rating_bar.dart';

import 'widget.dart';

Widget catererTile(BuildContext context, Caterer caterer) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    child: InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        height: 100,
        padding: EdgeInsets.all(5),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      'https://www.designwizard.com/wp-content/uploads/2019/03/65d80920-418a-11e9-b883-ebb378b89a58.jpg',
                    ),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        caterer.name,
                        style: GoogleFonts.roboto(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        caterer.email,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                        ),
                      ),
                    ]),
              ),
            ),
            Expanded(
              flex: 1,
              child: CustomBar(
                rating: caterer.rating,
                height: 120,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return CatererPage(
              caterer: caterer,
            );
          },
        ));
      },
    ),
  );
}
