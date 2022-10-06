import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:watchm_app/Api/ontheair.dart';
import 'package:watchm_app/Api/toprate.dart';
import 'package:http/http.dart' as http;
import 'package:watchm_app/Detail/OnTheAirDetail/ontadetai.dart';

class ontheaiir extends StatefulWidget {
  const ontheaiir({Key? key}) : super(key: key);

  @override
  State<ontheaiir> createState() => _ontheaiirState();
}

class _ontheaiirState extends State<ontheaiir> {
  //Api
  ontheair? ontheaire;
  bool isloaded = true;

  void ListPopular() async {
    setState(() {
      isloaded = false;
    });
    final res = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/tv/on_the_air?api_key=ddd0961778774abbadc977169438bddf&language=en-US&page=1"),
    );
    print("status code " + res.statusCode.toString());
    ontheaire = ontheair.fromJson(json.decode(res.body.toString()));
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

//ApiClose
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          height: 350,
          child: Center(
            child: isloaded == true
                ? ListView.builder(
                    itemCount: ontheaire!.results!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Detailon(
                                    results: ontheaire!.results![index])),
                          );
                        },
                        child: Card(
                          color: Color.fromARGB(255, 28, 28, 28),
                          child: Container(
                            margin: EdgeInsets.all(15),
                            child: Container(
                              child: Row(
                                children: [
                                  SizedBox(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: SizedBox(
                                          child: FadeInImage.assetNetwork(
                                            placeholder:
                                                'Image/Gif/output-onlinegiftools.gif',
                                            image:
                                                'https://www.themoviedb.org/t/p/w220_and_h330_face' +
                                                    ontheaire!.results![index]
                                                        .posterPath
                                                        .toString(),
                                            height: 100,
                                          ),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 200,
                                            child: Text(
                                              ontheaire!.results![index].name
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            width: 200,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5),
                                                  child: Icon(
                                                    Icons.people,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  ontheaire!.results![index]
                                                      .popularity
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 200,
                                            child: Text(
                                              ontheaire!
                                                  .results![index].firstAirDate
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                : CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
