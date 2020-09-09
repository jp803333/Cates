import 'package:Cates/View/colors.dart';
import 'package:flutter/cupertino.dart';

class CustomBar extends StatelessWidget {
  final double rating;
  final double height;
  CustomBar({
    @required this.rating,
    @required this.height,
  });
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1,
      child: Container(
        // padding: EdgeInsets.all(5),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: this.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: secondaryColorDark,
              ),
              width: 2,
            ),
            Container(
              height:
                  this.rating == null ? 0 : ((this.rating / 5) * this.height),
              width: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // color: secondaryColorLight,
                color: primaryColorLight,
              ),
            )
          ],
        ),
      ),
    );
  }
}
