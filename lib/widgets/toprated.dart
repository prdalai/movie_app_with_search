import 'package:flutter/material.dart';
import 'package:movie_app_with_search/utils/text.dart';

import '../description.dart';

class TopeRatedMovies extends StatefulWidget {
  final List toprated;

  const TopeRatedMovies({Key? key, required this.toprated}) : super(key: key);

  @override
  State<TopeRatedMovies> createState() => _TopeRatedMoviesState();
}

class _TopeRatedMoviesState extends State<TopeRatedMovies> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(
            text: 'Top Rated Movies',
            size: 26,
            color: Colors.white,
          ),
          SizedBox(height: 10),
          Container(
              height: 600,
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.toprated.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Description(
                                name: widget.toprated[index]['title'],
                                bannerurl:
                                'https://image.tmdb.org/t/p/w500' +
                                    widget.toprated[index]['backdrop_path'],
                                posterurl:
                                'https://image.tmdb.org/t/p/w500' +
                                    widget.toprated[index]['poster_path'],
                                description: widget.toprated[index]['overview'],
                                vote: widget.toprated[index]['vote_average']
                                    .toString(),
                                launch_on: widget.toprated[index]['release_date'],
                              )));
                    },
                    child: Container(
                      width: 140,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500' +
                                        widget.toprated[index]['poster_path']),
                              ),
                            ),
                            height: 150,
                          ),
                          SizedBox(height: 5),
                          Container(
                            child: modified_text(
                              size: 15,
                              text: widget.toprated[index]['title'] != null
                                  ? widget.toprated[index]['title']
                                  : 'Loading',
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
              ))
        ],
      ),
    );
  }
}
