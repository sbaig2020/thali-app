import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/request_provider.dart';
import '../widgets/request_card.dart';

class ProviderDashboardPage extends StatefulWidget {
  const ProviderDashboardPage({Key? key}) : super(key: key);

  @override
  State<ProviderDashboardPage> createState() => _ProviderDashboardPageState();
}

class _ProviderDashboardPageState extends State<ProviderDashboardPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<RequestProvider>(context, listen: false).loadAll();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<RequestProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Provider Dashboard')),
      body: prov.loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: prov.requests.length,
              itemBuilder: (c, i) => RequestCard(
                req: prov.requests[i],
                onMarkHandled: () => prov.markHandled(prov.requests[i].id),
              ),
            ),
    );
  }
}
