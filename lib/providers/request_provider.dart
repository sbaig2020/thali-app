import 'package:flutter/foundation.dart';
import '../models/request.dart';
import '../services/api_service.dart';

class RequestProvider extends ChangeNotifier {
  List<HelpRequest> _requests = [];
  bool loading = false;

  List<HelpRequest> get requests => _requests;

  Future<void> loadAll() async {
    loading = true;
    notifyListeners();
    _requests = await ApiService.fetchRequests();
    loading = false;
    notifyListeners();
  }

  Future<void> loadForName(String name) async {
    loading = true;
    notifyListeners();
    _requests = await ApiService.fetchRequests(name: name);
    loading = false;
    notifyListeners();
  }

  Future<void> add(Map<String, dynamic> body) async {
    loading = true;
    notifyListeners();
    final r = await ApiService.createRequest(body);
    _requests.insert(0, r);
    loading = false;
    notifyListeners();
  }

  Future<void> markHandled(String id) async {
    await ApiService.updateRequest(id, {'status': 'handled'});
    final i = _requests.indexWhere((r) => r.id == id);
    if (i != -1) {
      _requests[i] = HelpRequest(
        id: _requests[i].id,
        name: _requests[i].name,
        location: _requests[i].location,
        urgency: _requests[i].urgency,
        description: _requests[i].description,
        timestamp: _requests[i].timestamp,
        status: 'handled',
      );
      notifyListeners();
    }
  }

  Future<void> remove(String id) async {
    await ApiService.deleteRequest(id);
    _requests.removeWhere((r) => r.id == id);
    notifyListeners();
  }
}
