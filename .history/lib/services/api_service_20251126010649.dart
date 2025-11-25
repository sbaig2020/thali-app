import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/request.dart';

class ApiService {
  // Adjust this base URL for emulator or device. For Android emulator use http://10.0.2.2:3000
  static String baseUrl = 'http://localhost:3000';

  static Future<List<HelpRequest>> fetchRequests({String? name}) async {
    final uri = Uri.parse('$baseUrl/requests${name != null ? '?name=${Uri.encodeComponent(name)}' : ''}');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final List<dynamic> arr = jsonDecode(res.body);
      return arr.map((e) => HelpRequest.fromJson(e)).toList();
    }
    throw Exception('Failed to load requests');
  }

  static Future<HelpRequest> createRequest(Map<String, dynamic> body) async {
    final uri = Uri.parse('$baseUrl/requests');
    final res = await http.post(uri, body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (res.statusCode == 201) {
      return HelpRequest.fromJson(jsonDecode(res.body));
    }
    throw Exception('Failed to create request');
  }

  static Future<HelpRequest> updateRequest(String id, Map<String, dynamic> body) async {
    final uri = Uri.parse('$baseUrl/requests/$id');
    final res = await http.put(uri, body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (res.statusCode == 200) {
      return HelpRequest.fromJson(jsonDecode(res.body));
    }
    throw Exception('Failed to update request');
  }

  static Future<void> deleteRequest(String id) async {
    final uri = Uri.parse('$baseUrl/requests/$id');
    final res = await http.delete(uri);
    if (res.statusCode != 200) throw Exception('Failed to delete');
  }
}
