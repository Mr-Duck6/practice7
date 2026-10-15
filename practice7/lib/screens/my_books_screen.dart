import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/book.dart';

class MyBooksScreen extends StatelessWidget {
  const MyBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reservedBooks = LibraryData.books.where((b) => b.isReserved).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Мої книги')),
      body: reservedBooks.isEmpty
          ? const Center(child: Text('У вас немає заброньованих книг'))
          : ListView.builder(
              itemCount: reservedBooks.length,
              itemBuilder: (context, index) {
                final book = reservedBooks[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(
                      'Повернення до: ${book.returnDate?.toLocal().toString().split(' ')[0] ?? ''}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.red),
                    onPressed: () {
                      book.isReserved = false;
                      book.returnDate = null;
                      (context as Element).markNeedsBuild();
                    },
                  ),
                  onTap: () {
                    context.go('/catalog/book/${book.id}');
                  },
                );
              },
            ),
    );
  }
}
