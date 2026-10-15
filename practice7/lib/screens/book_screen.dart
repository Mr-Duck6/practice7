import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/book.dart';

class BookScreen extends StatelessWidget {
  final String bookId;

  const BookScreen({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    final book = LibraryData.findById(bookId);

    if (book == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Помилка')),
        body: const Center(child: Text('Книгу не знайдено')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Автор: ${book.author}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Жанр: ${book.genre}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Text(book.description, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 24),
            if (book.isReserved)
              Text(
                  'Статус: Заброньовано до ${book.returnDate?.toLocal().toString().split(' ')[0] ?? 'невідомо'}',
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold))
            else
              const Text('Статус: Доступна',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.push('/catalog/book/${book.id}/reserve');
                },
                child: const Text('Забронювати книгу'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
