import 'package:flutter/material.dart';
import '../model/movie.dart';
import '../services/api_services.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_screen.dart';

class CategoryMoviesScreen extends StatelessWidget {
  final String category;

  const CategoryMoviesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: FutureBuilder<List<Movie>>(
        future: APIservices().getMoviesByCategory(category),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final movies = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return MovieCard(
                movie: movies[index],
                width: double.infinity,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(movie: movies[index]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}