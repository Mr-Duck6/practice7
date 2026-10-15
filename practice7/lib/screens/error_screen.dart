import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  final String errorUri;

  const ErrorScreen({super.key, required this.errorUri});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Помилка 404')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Сторінку за адресою "$errorUri" не знайдено.', textAlign: TextAlign.center),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/catalog'),
                child: const Text('Повернутися до каталогу'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}