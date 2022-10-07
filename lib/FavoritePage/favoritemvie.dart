import 'package:flutter/material.dart';
import 'package:watchm_app/Api/toprate.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:watchm_app/Detail/PopularDetail/detailpop.dart';
import 'package:watchm_app/Detail/TopRateDetail/topdetail.dart';

class Favmviepge extends StatefulWidget {
  const Favmviepge({Key? key}) : super(key: key);

  @override
  State<Favmviepge> createState() => _FavmviepgeState();
}

class _FavmviepgeState extends State<Favmviepge> {
  var database;

  List<Results> movifav = <Results>[];

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

    getMovifav().then((value) {
      setState(() {
        movifav = value;
      });
    });
  }

//Read
  Future<List<Results>> getMovifav() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('results');
    print(movifav.toString());

    return List.generate(maps.length, (i) {
      return Results(
        id: maps[i]['id'] as int,
        title: maps[i]['title'] as String,
        overview: maps[i]['overview'] as String,
        originalLanguage: maps[i]['originalLanguage'] as String,
        posterPath: maps[i]['posterPath'],
        popularity: maps[i]['popularity'],
        voteCount: maps[i]['voteCount'],
        releaseDate: maps[i]['releaseDate'],
      );
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
  }

  @override
  void initState() {
    super.initState();
    initDb();
  }

  @override
  Widget build(BuildContext context) {
    if (movifav.length > 0) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
          ],
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            "Favorite",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        backgroundColor: Colors.black,
        body: ListView.builder(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Detailtop(
                            results: movifav[index],
                          )),
                ).then((value) => initDb());
                ;
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    color: Color.fromARGB(255, 28, 28, 28),
                    child: Container(
                      margin: EdgeInsets.all(15),
                      child: Container(
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: FadeInImage.assetNetwork(
                                placeholder:
                                    'Image/Gif/output-onlinegiftools.gif',
                                image:
                                    'https://www.themoviedb.org/t/p/w220_and_h330_face' +
                                        movifav[index].posterPath.toString(),
                                height: 100,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 150,
                                      child: Text(
                                        movifav[index].title.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 45),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Text("Delete " +
                                          movifav[index].title.toString()),
                                      content: Text("Are you sure to delete " +
                                          movifav[index].title.toString() +
                                          " from favorite"),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("No")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              deleteResult(movifav[index].id!)
                                                  .then((value) {
                                                getMovifav().then((value) {
                                                  setState(() {
                                                    movifav = value;
                                                  });
                                                });
                                              });
                                            },
                                            child: Text("Yes")),
                                      ],
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.delete_forever_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: movifav.length,
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
          ],
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            "Favorite",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            "You haven't added a favorite",
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }
}
