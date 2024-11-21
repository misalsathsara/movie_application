import 'package:flutter/material.dart';
import '../model/movie.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Movie> favorites;
  final Function(Movie) onToggleFavorite;

  const FavoritesScreen({
    super.key,
    required this.favorites,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Favorites')),
        body: const Center(
          child: Text('No favorite movies yet'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return MovieCard(
            movie: favorites[index],
            width: double.infinity,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailScreen(
                    movie: favorites[index],
                    onToggleFavorite: onToggleFavorite,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}