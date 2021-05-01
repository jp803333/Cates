import 'dart:ui';
import 'package:cates/Models/Core/Caterer.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;

Future<Color> averageColorFromImage(String url) async {
  // Uint8List yourVar;
  // final DecoderCallback callback = (Uint8List bytes,
  //     {bool allowUpscaling, int cacheWidth, int cacheHeight}) {
  //   yourVar = bytes.buffer.asUint8List();
  //   return instantiateImageCodec(bytes,
  //       targetWidth: cacheWidth, targetHeight: cacheHeight);
  // };
  // BuildContext context;
  // ImageProvider provider = NetworkImage(url);
  // provider.obtainKey(createLocalImageConfiguration(context)).then((key) {
  //   // provider.load(key, callback);
  //   provider.load(key, callback);
  // });
  http.Response res = await http.get(url);
  print(res.bodyBytes);
  img.Image bitmap = img.decodeImage(res.bodyBytes);
  int redPix = 0, greenPix = 0, bluePix = 0, totalPix = 0;
  for (var i = 0; i < bitmap.height; i++) {
    for (var j = 0; j < bitmap.width; j++) {
      int c = bitmap.getPixel(j, i);
      totalPix++;
      redPix += img.getRed(c);
      greenPix += img.getRed(c);
      bluePix += img.getRed(c);
    }
  }
  return Color.fromRGBO(
      redPix ~/ totalPix, greenPix ~/ totalPix, bluePix ~/ totalPix, 1);
}

class CatererPage extends StatefulWidget {
  final Caterer caterer;
  bool bookmarked = false;
  CatererPage({Key key, @required this.caterer}) : super(key: key);
  @override
  _CatererPageState createState() => _CatererPageState();
}

class _CatererPageState extends State<CatererPage>
    with TickerProviderStateMixin {
  Color _bgcolor;
  @override
  void initState() {
    averageColorFromImage(
      // widget.caterer.photo,
      'https://www.designwizard.com/wp-content/uploads/2019/03/65d80920-418a-11e9-b883-ebb378b89a58.jpg',
    ).then((value) {
      setState(() {
        _bgcolor = value;
      });
    });
    print(_bgcolor);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _bgcolor,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
                widget.bookmarked ? Icons.bookmark : Icons.bookmark_border),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              setState(() {
                widget.bookmarked = !widget.bookmarked;
              });
            },
          )
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: ClipPath(
                clipper: CTMPath(),
                child: Container(
                  height: 300,
                  color: _bgcolor,
                ),
              ),
            ),
            Positioned(
              top: 175,
              left: MediaQuery.of(context).size.width / 2 - 75,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  image: DecorationImage(
                      image: NetworkImage(
                        // widget.caterer.photo,
                        'https://www.designwizard.com/wp-content/uploads/2019/03/65d80920-418a-11e9-b883-ebb378b89a58.jpg',
                      ),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CTMPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

// class CatererPage extends StatefulWidget {
//   final Caterer caterer;
//   CatererPage({@required this.caterer});
//   @override
//   _CatererPageState createState() => _CatererPageState();
// }

// class _CatererPageState extends State<CatererPage>
//     with TickerProviderStateMixin {
//   AnimationController animaController;
//   Animation<double> cardResizeAnimation;
//   Animation<double> cardHeightResizeAnimation;
//   ScrollController _scrollController1 = ScrollController();
//   ScrollController _scrollController2 = ScrollController();
//   int index = 0;
//   bool scrolled = false;
//   TabController _tabController;
//   bool _isSaved = false;
//   @override
//   void initState() {
//     super.initState();
//     _tabController = new TabController(
//       initialIndex: 0,
//       length: 2,
//       vsync: this,
//     );
//     animaController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 75));
//     cardResizeAnimation =
//         Tween<double>(begin: 20, end: 10).animate(animaController);
//     cardHeightResizeAnimation =
//         Tween<double>(begin: 200, end: 30).animate(animaController);
//     _tabController.addListener(() {
//       setState(() {
//         index = _tabController.index;
//       });
//     });
//     _scrollController1.addListener(() {
//       if (_scrollController1.offset > 50 &&
//           // !animaController.isAnimating &&
//           !scrolled) {
//         setState(() {
//           animaController.forward();
//           scrolled = true;
//         });
//       } else if (_scrollController1.offset < 50 &&
//           // !animaController.isAnimating &&
//           scrolled) {
//         setState(() {
//           animaController.reverse();
//           scrolled = false;
//         });
//       }
//     });
//     _scrollController2.addListener(() {
//       if (_scrollController2.offset > 50 &&
//           // !animaController.isAnimating &&
//           !scrolled) {
//         setState(() {
//           animaController.forward();
//           scrolled = true;
//         });
//       }
//       if (_scrollController2.offset < 50 &&
//           // !animaController.isAnimating &&
//           scrolled) {
//         setState(() {
//           animaController.reverse();
//           scrolled = false;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _scrollController1.dispose();
//     _scrollController2.dispose();
//     animaController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Stack(
//         children: [
//           Image.network(
//             // caterer.photo,
//             'https://www.designwizard.com/wp-content/uploads/2019/03/65d80920-418a-11e9-b883-ebb378b89a58.jpg',
//             height: 300,
//             fit: BoxFit.fill,
//             width: double.infinity,
//           ),
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.transparent, Colors.white],
//                 begin: Alignment.topCenter,
//                 end:
//                     Alignment.lerp(Alignment.topCenter, Alignment.center, 0.75),
//               ),
//             ),
//           ),
//           AnimatedContainer(
//             duration: Duration(milliseconds: 200),
//             child: Positioned(
//               left: cardResizeAnimation.value,
//               right: cardResizeAnimation.value,
//               top: cardHeightResizeAnimation.value,
//               child: CatererPageCard(
//                 catererName: widget.caterer.name,
//               ),
//             ),
//           ),
//           Positioned(
//             height: 30,
//             top: 220 + cardHeightResizeAnimation.value,
//             left: 10,
//             right: 10,
//             child: CatererPageTabBar(tabController: _tabController),
//           ),
//           Positioned(
//             top: 250 + cardHeightResizeAnimation.value,
//             left: 10,
//             right: 10,
//             bottom: 0,
//             child: BottomTabView(
//               tabController: _tabController,
//               scrollController1: _scrollController1,
//               scrollController2: _scrollController2,
//               // cont: cont,
//               widget: widget,
//             ),
//           ),
//           Positioned(
//               top: 40,
//               right: 20,
//               child: IconButton(
//                 iconSize: 30,
//                 color: Colors.amber,
//                 icon: _isSaved
//                     ? Icon(Icons.bookmark)
//                     : Icon(Icons.bookmark_border),
//                 onPressed: () {
//                   setState(() {
//                     _isSaved = !_isSaved;
//                   });
//                 },
//               ))
//         ],
//       ),
//     );
//   }
// }

// class CatererPageCard extends StatelessWidget {
//   final catererName;
//   const CatererPageCard({
//     Key key,
//     @required String catererName,
//   })  : catererName = catererName,
//         super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       child: Container(
//         padding: EdgeInsets.all(10),
//         height: 200,
//         alignment: Alignment.topCenter,
//         child: Text(
//           catererName,
//           style: GoogleFonts.roboto(
//             color: Colors.white,
//             fontSize: 22,
//           ),
//         ),
//       ),
//       color: primaryColorDark,
//     );
//   }
// }

// class CatererPageTabBar extends StatelessWidget {
//   const CatererPageTabBar({
//     Key key,
//     @required TabController tabController,
//   })  : _tabController = tabController,
//         super(key: key);

//   final TabController _tabController;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       child: TabBar(
//         indicator: BoxDecoration(
//             color: primaryColorLight, borderRadius: BorderRadius.circular(25)),
//         controller: _tabController,
//         tabs: [
//           Text(
//             'FoodItems',
//             style: GoogleFonts.roboto(
//                 color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             'Reviews',
//             style: GoogleFonts.roboto(
//                 color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BottomTabView extends StatelessWidget {
//   const BottomTabView({
//     Key key,
//     @required TabController tabController,
//     @required ScrollController scrollController1,
//     @required ScrollController scrollController2,
//     @required this.widget,
//   })  : _tabController = tabController,
//         _scrollController1 = scrollController1,
//         _scrollController2 = scrollController2,
//         super(key: key);

//   final TabController _tabController;
//   final ScrollController _scrollController1;
//   final ScrollController _scrollController2;
//   final CatererPage widget;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // color: Colors.black,
//       child: TabBarView(
//         controller: _tabController,
//         children: [
//           ListView.builder(
//               controller: _scrollController1,
//               // itemCount: widget.caterer.foodItems.length,
//               itemCount: 10,
//               itemBuilder: (context, index) => Container(
//                     margin: EdgeInsets.all(5),
//                     height: 80,
//                     width: double.infinity,
//                     child: Row(
//                       children: [
//                         Container(
//                           height: 80,
//                           width: 80,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(40),
//                             image: DecorationImage(
//                                 image: NetworkImage(
//                                     widget.caterer.foodItems[0].photo),
//                                 fit: BoxFit.fill),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               widget.caterer.foodItems[0].name,
//                               style: GoogleFonts.roboto(
//                                   fontSize: 20, fontWeight: FontWeight.bold),
//                             ),
//                             Text(widget.caterer.foodItems[0].price),
//                           ],
//                         )
//                       ],
//                     ),
//                   )),
//           ListView.builder(
//             controller: _scrollController2,
//             // itemCount: widget.caterer.reviews.length,
//             itemCount: 10,
//             itemBuilder: (context, index) => Container(
//               margin: EdgeInsets.all(5),
//               height: 80,
//               width: double.infinity,
//               child: Row(
//                 children: [
//                   Container(
//                     height: 80,
//                     width: 80,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(40),
//                       color: Colors.amber,
//                     ),
//                     alignment: Alignment.center,
//                     child: Text(
//                       widget.caterer.reviews[0].rating.toString(),
//                       style: GoogleFonts.roboto(
//                         fontSize: 24,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     // mainAxisAlignment: MainAxisAlignment.spac,
//                     children: [
//                       Text(
//                         widget.caterer.reviews[0].username,
//                         style: GoogleFonts.roboto(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       Text(widget.caterer.reviews[0].msg),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// cont.addListener(() {
//       if (cont.offset > 50 && !animaController.isAnimating && !scrolled) {
//         setState(() {
//           animaController.forward();
//           scrolled = true;
//         });
//       }
//       if (cont.offset < 50 && !animaController.isAnimating && scrolled) {
//         setState(() {
//           animaController.reverse();
//           scrolled = false;
//         });
//       }
//     });
