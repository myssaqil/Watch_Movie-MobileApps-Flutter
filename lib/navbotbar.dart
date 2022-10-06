import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:watchm_app/Akunpge/myacct.dart';
import 'package:watchm_app/FavoritePage/favoritemvie.dart';
import 'package:watchm_app/Homepage/Explorepage.dart';
import 'package:watchm_app/whislist.dart';

class activitymain extends StatefulWidget {
  const activitymain({Key? key}) : super(key: key);

  @override
  State<activitymain> createState() => _activitymainState();
}

class _activitymainState extends State<activitymain> {
  int tab = 0;
  late Widget widgetny;
  @override
  void initState() {
    widgetny = const ExplorePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CurvedNavigationBar(
        items: const [
          Icon(Icons.movie_filter_outlined, size: 23),
          Icon(Icons.shop_rounded, size: 23),
          Icon(Icons.favorite, size: 23),
          Icon(Icons.account_circle, size: 23),
        ],
        onTap: onPressed,
        backgroundColor: Colors.black,
        height: 50,
      ),
      body: widgetny,
    );
  }

  void onPressed(index) {
    setState(() {
      tab = index;
      if (index == 0) {
        widgetny = ExplorePage();
      } else if (index == 1) {
        widgetny = Whislist();
      } else if (index == 2) {
        widgetny = Favmviepge();
      } else if (index == 3) {
        widgetny = myprofile();
      }
    });
  }
}
