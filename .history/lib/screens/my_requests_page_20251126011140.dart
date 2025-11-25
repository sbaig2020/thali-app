import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/storage_service.dart';
import '../providers/request_provider.dart';
import '../widgets/request_card.dart';

class MyRequestsPage extends StatefulWidget {
  const MyRequestsPage({Key? key}) : super(key: key);

  @override
  State<MyRequestsPage> createState() => _MyRequestsPageState();
}

class _MyRequestsPageState extends State<MyRequestsPage> {
  String _name = '';

  @override
  void initState() {
    super.initState();
    StorageService.getName().then((v) async {
      if (v != null) {
        _name = v;
        await Provider.of<RequestProvider>(context, listen: false).loadForName(_name);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<RequestProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('My Requests')),
      body: prov.loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: prov.requests.length,
              itemBuilder: (c, i) => RequestCard(req: prov.requests[i]),
            ),
    );
  }
}
