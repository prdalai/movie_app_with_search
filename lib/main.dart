import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:movie_app_with_search/utils/text.dart';
import 'package:movie_app_with_search/widgets/toprated.dart';
import 'package:movie_app_with_search/widgets/trending.dart';
import 'package:tmdb_api/tmdb_api.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.green),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String apikey = '860b311988b2268abae0e03d31905200';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NjBiMzExOTg4YjIyNjhhYmFlMGUwM2QzMTkwNTIwMCIsInN1YiI6IjYyZDAxMDI4YjIzNGI5MDA0Y2QzODJmNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2Ear9w_hntxETkjWuplmj7pwStRRUyn7qSVbt6REfzg';
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];

  @override
  void initState() {
    super.initState();
    loadmovies();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPouplar();
    print((trendingresult));
    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: modified_text(
            text: 'Flutter Movie App ❤️',
            size: 24,
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                Get.to(TopeRatedMovies(toprated: [],));
              },
              icon: Icon(Icons.filter_list_sharp),
            ),
          ],
        ),
        body: ListView(
          children: [
            TrendingMovies(
              trending: trendingmovies,
            ),
          ],
        ));
  }
}
