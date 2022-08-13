import  'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:list_view/ui/movie_ui.dart';

import 'model/movie.dart';

void main() {
  runApp(const MaterialApp(
    title: "Movie App",
    home: MyApp(),
  ));
}





class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Movie> movieList = Movie.getMovies();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "LisView",
          style: TextStyle(fontSize: 26),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
          itemCount: movieList.length,
          itemBuilder: (BuildContext context, index) {
            return Stack(children: [
              movieCard(movieList[index], context),
              creatImage(movieList[index].images[0]),
            ]);
          }),
    );
  }

  Widget movieCard(Movie movie, BuildContext context) {
      return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60),
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        movie.title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        "Raiting ${movie.imdbRating}/10",
                        style: communStyle(),
                      ),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Released : ${movie.released}",
                      style: communStyle(),
                    ),
                    Text(movie.runtime, style: communStyle()),
                    Text(movie.rated, style: communStyle())
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MovieListViewDetail(movieName: movie.title, movie: movie)));
      },
    );
  }

  Widget creatImage(String url) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
    );
  }

  TextStyle communStyle() {
    return TextStyle(color: Colors.grey, fontSize: 15);
  }
}

class MovieListViewDetail extends StatelessWidget {
  final String movieName;
  final Movie movie;

  const MovieListViewDetail(
      {Key? key, required this.movieName, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: ListView(
        children: [
          MovieDetailsThumbNail(thumbnail: movie.images[0]),
          MovieDetailsHeaderWithPoser(movie: movie),
          HorizontalLine(),
          MovieDetailsCast(movie: movie),
          HorizontalLine(),
          MovieDetailsExtraPosters(poster: movie.images)
        ],
      ),
    );
  }
}
