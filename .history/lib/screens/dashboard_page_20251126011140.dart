import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String name = '';
  String? transfusion;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    final n = await StorageService.getName();
    final t = await StorageService.getTransfusion();
    setState(() {
      name = n ?? '';
      transfusion = t;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thali Help')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Hello, $name', style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Upcoming transfusion: ${transfusion ?? 'Not set'}'),
                  SizedBox(height: 8),
                  ElevatedButton(onPressed: () async {
                    final v = await showDialog<String?>(context: context, builder: (c) {
                      final ctrl = TextEditingController(text: transfusion ?? '');
                      return AlertDialog(
                        title: Text('Set transfusion date (text)'),
                        content: TextField(controller: ctrl),
                        actions: [TextButton(onPressed: () => Navigator.pop(c), child: Text('Cancel')), TextButton(onPressed: () => Navigator.pop(c, ctrl.text), child: Text('Save'))],
                      );
                    });
                    if (v != null) {
                      await StorageService.saveTransfusion(v);
                      setState(() => transfusion = v);
                    }
                  }, child: Text('Edit'))
                ]),
              ),
            ),
            SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Tips', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Bring your ID, arrive 30 minutes early, bring a companion.'),
                ]),
              ),
            ),
            SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Emergency instructions', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('If immediate danger, call local emergency services.'),
                ]),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/request'), child: Text('Request Help')),
            SizedBox(height: 8),
            OutlinedButton(onPressed: () => Navigator.pushNamed(context, '/my_requests'), child: Text('My Requests')),
          ],
        ),
      ),
    );
  }
}
