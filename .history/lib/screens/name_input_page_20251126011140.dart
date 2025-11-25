import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class NameInputPage extends StatefulWidget {
  const NameInputPage({Key? key}) : super(key: key);

  @override
  State<NameInputPage> createState() => _NameInputPageState();
}

class _NameInputPageState extends State<NameInputPage> {
  final _ctrl = TextEditingController();

  void _save() async {
    final name = _ctrl.text.trim();
    if (name.isEmpty) return;
    await StorageService.saveName(name);
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome to Thali Help')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Text('Enter your name', style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 12),
            TextField(controller: _ctrl, decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Name')),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _save, child: Text('Continue'))
          ],
        ),
      ),
    );
  }
}
