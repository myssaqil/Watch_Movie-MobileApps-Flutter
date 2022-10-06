import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:watchm_app/Api/comingsoon.dart';
import 'package:watchm_app/Api/popularMovie.dart';
import 'package:watchm_app/Detail/PopularDetail/detailpop.dart';
import 'package:watchm_app/Homepage/ComingSoon.dart';
import 'package:watchm_app/Homepage/Ontheair.dart';
import 'package:watchm_app/Homepage/TopRate.dart';
import 'package:watchm_app/LoginPage/getStart.dart';
import 'package:watchm_app/authen/authentication.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
//PopularApi
  Popularmovie? popularmoviee;
  bool isloaded = true;

  void ListPopular() async {
    setState(() {
      isloaded = false;
    });
    final res = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/movie/popular?api_key=ddd0961778774abbadc977169438bddf&language=en-US&page=1"),
    );
    print("status code " + res.statusCode.toString());
    popularmoviee = Popularmovie.fromJson(json.decode(res.body.toString()));
    setState(() {
      isloaded = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ListPopular();
  }
//PopularApiClose

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      endDrawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 320,
              decoration: BoxDecoration(
                image: new DecorationImage(
                    image: AssetImage(
                      "Image/Logo.png",
                    ),
                    fit: BoxFit.fitWidth),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: const Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Image.asset("Image/LogoPng/twet.png"),
              title: const Text(
                'iyiyaaqil',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {
                await launchUrl(Uri.parse("https://twitter.com/Iyiyaaqil"));
              },
            ),
            ListTile(
              leading: Image.asset("Image/LogoPng/ig.png"),
              title: const Text(
                'iyiyaaqil',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {
                await launchUrl(
                    Uri.parse("https://www.instagram.com/iyiyaaqil/"));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure to logout"),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("No")),
                      TextButton(
                          onPressed: () {
                            AuthenticationHelper()
                                .signOut()
                                .then((_) => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (contex) => MainPage()),
                                    ));
                          },
                          child: Text("Yes")),
                    ],
                  ),
                );

                ///
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              )),
        ],
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "Explore",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child:
            ListView(physics: const NeverScrollableScrollPhysics(), children: [
          Text(
            "Popular",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 205,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Container(
                    child: Center(
                      child: isloaded == true
                          ? Container(
                              height: 200,
                              child: ListView.builder(
                                  itemCount: popularmoviee!.results!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailPop(
                                                  results: popularmoviee!
                                                      .results![index])),
                                        );
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        color: Color.fromARGB(255, 28, 28, 28),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Container(
                                            width: 100,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: FadeInImage
                                                        .assetNetwork(
                                                      placeholder:
                                                          'Image/Gif/output-onlinegiftools.gif',
                                                      image:
                                                          'https://www.themoviedb.org/t/p/w220_and_h330_face' +
                                                              popularmoviee!
                                                                  .results![
                                                                      index]
                                                                  .posterPath
                                                                  .toString(),
                                                      width: 80,
                                                    )),
                                                Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Text(
                                                      popularmoviee!
                                                          .results![index].title
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          : CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 100,
            child: DefaultTabController(
                length: 3, // length of tabs
                initialIndex: 0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: TabBar(
                          labelColor: Colors.blue,
                          unselectedLabelColor: Colors.white,
                          tabs: [
                            Tab(text: 'Top Rate'),
                            Tab(text: 'ComingSoon'),
                            Tab(text: 'On The Air'),
                          ],
                        ),
                      ),
                      Container(
                          height: 340, //height of TabBarView

                          child: TabBarView(children: <Widget>[
                            TopRate(),
                            Comingsoon(),
                            ontheaiir()
                          ]))
                    ])),
          ),
        ]),
      ),
    );
  }
}
