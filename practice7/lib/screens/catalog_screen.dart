import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/book.dart';

class CatalogScreen extends StatelessWidget {
  final String? selectedGenre;

  const CatalogScreen({super.key, this.selectedGenre});

  @override
  Widget build(BuildContext context) {
    final genres = LibraryData.genres;
    final currentGenre = selectedGenre ?? 'Всі';

    final filteredBooks = currentGenre == 'Всі'
        ? LibraryData.books
        : LibraryData.books.where((b) => b.genre == currentGenre).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Каталог бібліотеки'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: genres.length,
              itemBuilder: (context, index) {
                final genre = genres[index];
                final isSelected = genre == currentGenre;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 8.0),
                  child: ChoiceChip(
                    label: Text(genre),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (genre == 'Всі') {
                        context.go('/catalog');
                      } else {
                        context.go('/catalog?genre=$genre');
                      }
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                final book = filteredBooks[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text('${book.author} (${book.genre})'),
                  trailing: book.isReserved
                      ? const Icon(Icons.lock, color: Colors.orange)
                      : null,
                  onTap: () {
                    context.go('/catalog/book/${book.id}');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
