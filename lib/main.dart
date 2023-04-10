import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'movies', home: ListScreen());
  }
}

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Movie> myMovies = [];

  @override
  void initState() {
    super.initState();
    assignMovies();
  }

  void assignMovies() {
    setState(() {
      myMovies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (c, i) => ListTile(
          leading: Image.network(myMovies[i].imageUrl),
          title: Text(myMovies[i].title),
          trailing:
              Icon(!myMovies[i].isFavorited ? Icons.star_border : Icons.star),
          onTap: () async {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => DetailScreen(movie: myMovies[i]),
              ),
            );
            result ??= myMovies[i].isFavorited;
            setState(() {
              myMovies[i].isFavorited = result;
            });
          },
        ),
        itemCount: myMovies.length,
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  final Movie movie;
  const DetailScreen({super.key, required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(widget.movie.imageUrl),
            Text(widget.movie.title),
            Text(widget.movie.description),
            ElevatedButton(
              child: Text(widget.movie.isFavorited ? "Unfavorite" : "Favorite"),
              onPressed: () {
                Navigator.pop(context, !widget.movie.isFavorited);
              },
            )
          ],
        ),
      ),
    );
  }
}

class Movie {
  String title;
  String description;
  String imageUrl;
  bool isFavorited;

  Movie({
    required this.title,
    required this.description,
    required this.imageUrl,
    this.isFavorited = false,
  });
}

final List<Movie> movies = [
  Movie(
    title: 'The Shawshank Redemption',
    description:
        'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.',
    imageUrl:
        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg',
  ),
  Movie(
    title: 'The Godfather',
    description:
        'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.',
    imageUrl:
        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/rPdtLWNsZmAtoZl9PK7S2wE3qiS.jpg',
  ),
  Movie(
    title: 'The Dark Knight',
    description:
        'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
    imageUrl:
        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
  ),
];
