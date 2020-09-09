import 'package:Cates/Models/Core/Caterer.dart';
// import 'package:Cates/View/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Fluid_rating_bar.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'widget.dart';

Widget catererTile(BuildContext context, Caterer caterer) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    // padding: EdgeInsets.all(10),
    child: InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        // color: Colors.amber,
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
                  // color: Colors.amber,
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
                // color: Colors.amber,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        caterer.name,
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      Text(
                        caterer.email,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          // fontWeight: FontWeight.w500
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
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(10),
        //   image: DecorationImage(
        //       image: NetworkImage(
        //         // 'https://dummyimage.com/250x150/f4f/000',
        //         // caterer.photo,
        //         'https://www.designwizard.com/wp-content/uploads/2019/03/65d80920-418a-11e9-b883-ebb378b89a58.jpg',
        //       ),
        //       fit: BoxFit.fill),
        // ),
        // child: Container(
        //   height: 150,
        //   padding: EdgeInsets.all(10),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10),
        //     gradient: LinearGradient(
        //       colors: [Colors.transparent, primaryColor],
        //       begin: Alignment.topLeft,
        //       end: Alignment.bottomCenter,
        //     ),
        //   ),
        //   child:
        // ),
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

// Row(
//             children: [
//               CustomBar(
//                 rating: caterer.rating,
//                 height: 120,
//               ),
//             ],
//           ),
