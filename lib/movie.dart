import 'package:flutter/material.dart';
import 'package:movie/Provider/movieService.dart';
import 'package:provider/provider.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final textEditingController = TextEditingController();
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Home",
            style: TextStyle(
                fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Consumer<MovieService>(
        builder: (context, service, _) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 2, 20, 2),
              child: Container(
                child: TextField(
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                          onTap: () {
                            print(search);
                            service.movieList(search);
                          },
                          child: Icon(Icons.search)),
                      hintText: 'Search for Movies..',
                      border: OutlineInputBorder()),
                  controller: textEditingController,
                  onChanged: (value) {
                    setState(() {
                      search = textEditingController.text;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: service.movies.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                    child: Card(
                      elevation: 3.0,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 180,
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage(
                                  placeholder:
                                      AssetImage('assets/images/Ad.jpeg'),
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          service.movies[index].posterPath),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      service.movies[index].originalTitle,
                                      maxLines: 4,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(service.movies[index].genreIds
                                      .toString()),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 70,
                                    height: 15,
                                    decoration: BoxDecoration(
                                        color:
                                            service.movies[index].voteAverage >
                                                    7
                                                ? Colors.green
                                                : Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      service.movies[index].voteAverage
                                              .toString() +
                                          '  IMDB',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
