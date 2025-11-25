import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/name_input_page.dart';
import 'screens/dashboard_page.dart';
import 'screens/request_help_page.dart';
import 'screens/my_requests_page.dart';
import 'screens/provider_dashboard_page.dart';
import 'screens/admin_dashboard_page.dart';
import 'providers/request_provider.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final name = await StorageService.getName();
  runApp(MyApp(startRoute: name == null ? '/name' : '/dashboard'));
}

class MyApp extends StatelessWidget {
  final String startRoute;
  const MyApp({Key? key, required this.startRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RequestProvider(),
      child: MaterialApp(
        title: 'Thali Help',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.redAccent),
        initialRoute: startRoute,
        routes: {
          '/name': (_) => NameInputPage(),
          '/dashboard': (_) => DashboardPage(),
          '/request': (_) => RequestHelpPage(),
          '/my_requests': (_) => MyRequestsPage(),
          '/provider': (_) => ProviderDashboardPage(),
          '/admin': (_) => AdminDashboardPage(),
          '/request_success': (_) => Scaffold(appBar: AppBar(title: Text('Success')), body: Center(child: Text('Request submitted'))),
        },
      ),
    );
  }
}
