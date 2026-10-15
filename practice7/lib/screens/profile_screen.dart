import 'package:flutter/material.dart';
import '../router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController(text: 'Іван студент');
  final _cardController = TextEditingController(text: 'KB-2026-99');
  bool _isDirty = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_markDirty);
    _cardController.addListener(_markDirty);
  }

  void _markDirty() {
    if (!_isDirty) setState(() => _isDirty = true);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (!_isDirty) return true;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Незбережені зміни'),
        content: const Text('Ви дійсно хочете вийти без збереження?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Скасувати')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Вийти')),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isDirty,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          setState(() => _isDirty = false);
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Профіль користувача')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Ім’я читача'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _cardController,
                decoration: const InputDecoration(labelText: 'Номер читацького квитка'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() => _isDirty = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Зміни збережено')),
                  );
                },
                child: const Text('Зберегти'),
              ),
              const Spacer(),
              if (authNotifier.isAuthenticated)
                OutlinedButton(
                  onPressed: () {
                    authNotifier.logout();
                  },
                  child: const Text('Вийти з акаунта'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}