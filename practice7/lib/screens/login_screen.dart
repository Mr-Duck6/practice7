import 'package:flutter/material.dart';
import '../router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Вхід у систему')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Для бронювання книг необхідна авторизація.', textAlign: TextAlign.center),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  authNotifier.login();
                },
                child: const Text('Увійти'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}