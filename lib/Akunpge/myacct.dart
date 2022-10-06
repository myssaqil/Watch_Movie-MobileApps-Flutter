import 'package:flutter/material.dart';

class myprofile extends StatefulWidget {
  const myprofile({Key? key}) : super(key: key);

  @override
  State<myprofile> createState() => _myprofileState();
}

class _myprofileState extends State<myprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              )),
        ],
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "Bknaqillll",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(150.0),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'Image/Gif/output-onlinegiftools.gif',
                    image:
                        'https://i.pinimg.com/236x/ba/25/a0/ba25a09af3bb0992ab0750d1401823c9.jpg',
                    width: 180,
                  )),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 30, bottom: 20),
            child: Text(
              "Bknaqillll",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
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
                            Tab(
                              text: 'Profile',
                            ),
                            Tab(text: 'Post'),
                            Tab(text: 'Tagged'),
                          ],
                        ),
                      ),
                      Container(
                          height: 300, //height of TabBarView

                          child: TabBarView(children: <Widget>[
                            Center(
                              child: Text(
                                "It's cloudy here",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Center(
                              child: Text(
                                "It's cloudy here",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Center(
                              child: Text(
                                "It's cloudy here",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ]))
                    ])),
          ),
        ],
      ),
    );
  }
}
