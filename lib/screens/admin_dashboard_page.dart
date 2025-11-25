import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/request_provider.dart';
import '../widgets/request_card.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({Key? key}) : super(key: key);

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<RequestProvider>(context, listen: false).loadAll();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<RequestProvider>(context);
    final total = prov.requests.length;
    final pending = prov.requests.where((r) => r.status == 'pending').length;
    final handled = prov.requests.where((r) => r.status == 'handled').length;

    return Scaffold(
      appBar: AppBar(title: Text('Admin')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text('Total: $total'),
            Text('Pending: $pending'),
            Text('Handled: $handled'),
          ]),
        ),
        Expanded(
          child: prov.loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: prov.requests.length,
                  itemBuilder: (c, i) => RequestCard(req: prov.requests[i], onDelete: () => prov.remove(prov.requests[i].id)),
                ),
        )
      ]),
    );
  }
}
