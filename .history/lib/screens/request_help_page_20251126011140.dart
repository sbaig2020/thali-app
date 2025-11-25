import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/storage_service.dart';
import '../providers/request_provider.dart';

class RequestHelpPage extends StatefulWidget {
  const RequestHelpPage({Key? key}) : super(key: key);

  @override
  State<RequestHelpPage> createState() => _RequestHelpPageState();
}

class _RequestHelpPageState extends State<RequestHelpPage> {
  final _loc = TextEditingController();
  final _desc = TextEditingController();
  String _urgency = 'Low';
  String _name = '';

  @override
  void initState() {
    super.initState();
    StorageService.getName().then((v) {
      if (v != null) setState(() => _name = v);
    });
  }

  void _submit() async {
    final provider = Provider.of<RequestProvider>(context, listen: false);
    await provider.add({
      'name': _name,
      'location': _loc.text.trim(),
      'urgency': _urgency,
      'description': _desc.text.trim(),
    });
    Navigator.pushReplacementNamed(context, '/request_success');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Request Help')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          TextField(controller: TextEditingController(text: _name), enabled: false, decoration: InputDecoration(labelText: 'Name')),
          SizedBox(height: 8),
          TextField(controller: _loc, decoration: InputDecoration(labelText: 'Location')),
          SizedBox(height: 8),
          DropdownButtonFormField<String>(value: _urgency, items: ['Low', 'Medium', 'High'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => _urgency = v ?? 'Low'), decoration: InputDecoration(labelText: 'Urgency')),
          SizedBox(height: 8),
          TextField(controller: _desc, decoration: InputDecoration(labelText: 'Description'), maxLines: 4),
          SizedBox(height: 12),
          ElevatedButton(onPressed: _submit, child: Text('Submit'))
        ]),
      ),
    );
  }
}
