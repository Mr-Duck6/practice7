import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/book.dart';

class ReserveScreen extends StatefulWidget {
  final String bookId;

  const ReserveScreen({super.key, required this.bookId});

  @override
  State<ReserveScreen> createState() => _ReserveScreenState();
}

class _ReserveScreenState extends State<ReserveScreen> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final book = LibraryData.findById(widget.bookId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Бронювання книги'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Книга: ${book?.title ?? ''}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  _selectedDate == null
                      ? 'Дата повернення не вибрана'
                      : 'Дата повернення: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
                ),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    final result = await context.push<DateTime>(
                        '/catalog/book/${widget.bookId}/reserve/date-picker');
                    if (result != null) {
                      setState(() {
                        _selectedDate =
                            result;
                      });
                    }
                  },
                  child: const Text('Вибрати дату'),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedDate == null
                    ? null
                    : () {
                        if (book != null) {
                          book.isReserved = true;
                          book.returnDate = _selectedDate;
                        }
                        context.go('/catalog');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Книгу успішно заброньовано!')),
                        );
                      },
                child: const Text('Підтвердити бронювання'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
