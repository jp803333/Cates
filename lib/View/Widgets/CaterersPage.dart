import 'package:Cates/Models/Core/Caterer.dart';
import 'package:Cates/View/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CatererPage extends StatefulWidget {
  final Caterer caterer;
  CatererPage({@required this.caterer});
  @override
  _CatererPageState createState() => _CatererPageState();
}

class _CatererPageState extends State<CatererPage>
    with TickerProviderStateMixin {
  AnimationController animaController;
  Animation<double> cardResizeAnimation;
  Animation<double> cardHeightResizeAnimation;
  ScrollController cont = ScrollController();
  bool scrolled = false;
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    animaController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 50));
    cardResizeAnimation =
        Tween<double>(begin: 20, end: 0).animate(animaController);
    cardHeightResizeAnimation =
        Tween<double>(begin: 200, end: 0).animate(animaController);

    cont.addListener(() {
      setState(() {
        if (cont.offset > 1 &&
            animaController.isAnimating == false &&
            !scrolled) {
          animaController.forward();
          scrolled = true;
        }
        if (cont.offset < 1 &&
            animaController.isAnimating == false &&
            scrolled) {
          animaController.reverse();
          scrolled = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Image.network(
            // caterer.photo,
            'https://www.designwizard.com/wp-content/uploads/2019/03/65d80920-418a-11e9-b883-ebb378b89a58.jpg',
            height: 300,
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.white],
                begin: Alignment.topCenter,
                end:
                    Alignment.lerp(Alignment.topCenter, Alignment.center, 0.75),
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            child: Positioned(
              left: cardResizeAnimation.value,
              right: cardResizeAnimation.value,
              top: cardHeightResizeAnimation.value,
              child: CatererPageCard(
                catererName: widget.caterer.name,
              ),
            ),
          ),
          Positioned(
            height: 30,
            top: 220 + cardHeightResizeAnimation.value,
            left: 10,
            right: 10,
            child: CatererPageTabBar(tabController: _tabController),
          ),
          Positioned(
            top: 250 + cardHeightResizeAnimation.value,
            left: 10,
            right: 10,
            bottom: 0,
            child: BottomTabView(
              tabController: _tabController,
              cont: cont,
              widget: widget,
            ),
          ),
        ],
      ),
    );
  }
}

class CatererPageCard extends StatelessWidget {
  final catererName;
  const CatererPageCard({
    Key key,
    @required String catererName,
  })  : catererName = catererName,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(10),
        height: 200,
        alignment: Alignment.topCenter,
        child: Text(
          catererName,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
      color: primaryColorDark,
    );
  }
}

class CatererPageTabBar extends StatelessWidget {
  const CatererPageTabBar({
    Key key,
    @required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TabBar(
        indicator: BoxDecoration(
            color: primaryColorLight, borderRadius: BorderRadius.circular(25)),
        controller: _tabController,
        tabs: [
          Text(
            'FoodItems',
            style: GoogleFonts.roboto(
                color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Reviews',
            style: GoogleFonts.roboto(
                color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Details',
            style: GoogleFonts.roboto(
                color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class BottomTabView extends StatelessWidget {
  const BottomTabView({
    Key key,
    @required TabController tabController,
    @required this.cont,
    @required this.widget,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;
  final ScrollController cont;
  final CatererPage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black,
      child: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
              controller: cont,
              // itemCount: widget.caterer.foodItems.length,
              itemCount: 10,
              itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.all(5),
                    height: 80,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            image: DecorationImage(
                                image: NetworkImage(
                                    widget.caterer.foodItems[0].photo),
                                fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.caterer.foodItems[0].name,
                              style: GoogleFonts.roboto(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(widget.caterer.foodItems[0].price),
                          ],
                        )
                      ],
                    ),
                  )),
          ListView.builder(
            // itemCount: widget.caterer.reviews.length,
            controller: cont,
            itemCount: 10,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.all(5),
              height: 80,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.amber,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.caterer.reviews[0].rating.toString(),
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spac,
                    children: [
                      Text(
                        widget.caterer.reviews[0].username,
                        style: GoogleFonts.roboto(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(widget.caterer.reviews[0].msg),
                    ],
                  )
                ],
              ),
            ),
            // Text(widget.caterer.reviews[index].username),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.caterer.email,
                  style: GoogleFonts.roboto(
                    color: primaryColor,
                    fontSize: 18,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '+91 ' + widget.caterer.mobile,
                  style: GoogleFonts.roboto(
                    color: primaryColor,
                    fontSize: 18,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(widget.caterer.address.line1),
                Text(widget.caterer.address.line2),
                Text(widget.caterer.address.city),
                Text(widget.caterer.address.state),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
