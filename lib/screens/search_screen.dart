import 'package:flutter/material.dart';
import 'package:movie_application/screens/movie_detail_screen.dart';
import '../model/movie.dart';
import '../services/api_services.dart';
import '../widgets/movie_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final APIservices apiServices = APIservices();
  List<Movie> movies = [];
  bool isLoading = false;
  String searchQuery = "";

  void _searchMovies(String query) async {
    if (query.isEmpty) return; // Ignore empty searches

    setState(() {
      searchQuery = query;
      isLoading = true;
      movies = [];
    });

    try {
      final results = await apiServices.searchMovies(query);
      setState(() {
        movies = results;
      });
    } catch (e) {
      setState(() {
        movies = [];
      });
      debugPrint("Error fetching search results: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search for movies...',
            border: InputBorder.none,
          ),
          onChanged: _searchMovies, // Call search when user types
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : movies.isEmpty
              ? const Center(
                  child: Text(
                    "No movies found.",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two items per row
                    crossAxisSpacing: 8, // Consistent horizontal spacing
                    mainAxisSpacing: 12, // Consistent vertical spacing
                    childAspectRatio:
                        0.68, // Fix aspect ratio for movie posters
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 7, // Allocate space for the poster image
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w500${movie.backDropPath}",
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Expanded(
                              flex:
                                  3, // Allocate space for the title and rating
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.black87,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.amber, size: 14),
                                        const SizedBox(width: 4),
                                        Text(
                                          movie.rating.toString(),
                                          style: const TextStyle(
                                              color: Colors.white70),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
