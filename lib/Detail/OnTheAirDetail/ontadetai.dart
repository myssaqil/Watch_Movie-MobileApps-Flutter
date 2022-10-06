import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../../Api/ontheair.dart';

class Detailon extends StatefulWidget {
  Detailon({Key? key, required this.results}) : super(key: key);
  Results results;

  @override
  State<Detailon> createState() => _DetailonState();
}

class _DetailonState extends State<Detailon> {
  @override
  Widget build(BuildContext context) {
    //nullcheckandchange
    String notnull = widget.results.popularity.toString();
    String fngsinull = "tidak ada data";
    if (widget.results.popularity == null) {
      setState(() {
        notnull = fngsinull;
      });
    }
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
            onTap: (() {
              Navigator.pop(context);
            }),
          ),
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text(widget.results.name.toString()),
        ),
        body: Stack(
          children: [
            Container(
              child: ImageSlideshow(
                autoPlayInterval: 2000,
                indicatorRadius: 0,
                isLoop: true,
                children: [
                  Image.asset("Image/poster/1.png"),
                  Image.asset("Image/poster/2.png"),
                  Image.asset("Image/poster/3.png"),
                  Image.asset("Image/poster/4.png")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 190),
              child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 28, 28, 28),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            SizedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: FadeInImage.assetNetwork(
                                  placeholder:
                                      'Image/Gif/output-onlinegiftools.gif',
                                  image:
                                      'https://www.themoviedb.org/t/p/w220_and_h330_face' +
                                          widget.results.posterPath.toString(),
                                  height: 100,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 200,
                                      child: Text(
                                        widget.results.name.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      width: 200,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Icon(
                                              Icons.people,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            notnull,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      child: Text(
                                        'language : ' +
                                            widget.results.originalLanguage
                                                .toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      child: Text(
                                        'First Air Date : ' +
                                            widget.results.firstAirDate
                                                .toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      child: Text(
                                        'Genre Id : ' +
                                            widget.results.genreIds.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      child: Text(
                                        'Id : ' + widget.results.id.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      child: Text(
                                        'language : ' +
                                            widget.results.originalLanguage
                                                .toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Overview :',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 300,
                              child: Text(
                                widget.results.overview.toString(),
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      )
                    ],
                  )),
            ),
          ],
        ));
  }
}
