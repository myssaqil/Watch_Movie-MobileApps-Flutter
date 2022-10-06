import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:watchm_app/Api/toprate.dart';
import 'package:watchm_app/Homepage/TopRate.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Detailtop extends StatefulWidget {
  Detailtop({Key? key, required this.results}) : super(key: key);
  Results results;

  @override
  State<Detailtop> createState() => _DetailtopState();
}

class _DetailtopState extends State<Detailtop> {
  bool onthefav = false;
  var database;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDb();
  }

//open database
  Future initDb() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'results_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE results(id INTEGER, title TEXT, posterPath TEXT, overview TEXT, originalLanguage TEXT, popularity INTEGER, voteCount INTEGER, releaseDate INTEGER)',
        );
      },
      version: 1,
    );
  }

//Memasukkan data dari api ke database
  Future<void> insertApi(Results results) async {
    final db = await database;
    await db.insert(
      'results',
      results.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    setState(() {
      onthefav = true;
    });
  }

  //Delete data
  Future<void> deleteResult(int? id) async {
    final db = await database;
    await db.delete(
      'results',
      where: 'id = ?',
      whereArgs: [id],
    );
    setState(() {
      onthefav = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  //memanggil fungsi diatas
                  insertApi(widget.results);
                },
                icon: Icon(
                  (onthefav == false)
                      ? Icons.favorite_border_outlined
                      : Icons.favorite,
                  color: (onthefav == false) ? Colors.white : Colors.red,
                )),
          ],
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
          title: Text(widget.results.title.toString()),
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
                                        widget.results.title.toString(),
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
                                            widget.results.popularity
                                                .toString(),
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
                                        'Release Date : ' +
                                            widget.results.releaseDate
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
                                        'id : ' + widget.results.id.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      child: Text(
                                        'adult : ' +
                                            widget.results.adult.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      child: Text(
                                        'Vote Count : ' +
                                            widget.results.voteCount.toString(),
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
