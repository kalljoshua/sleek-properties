import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiUrl = 'http://127.0.0.1:8000/api/properties';
const String fetchError = 'Failed to fetch properties';

class PropertyService {
  Future<List<dynamic>> fetchProperties() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(fetchError);
    }
  }

  Future<void> addProperty(Map<String, dynamic> property) async {
    await http.post(Uri.parse(apiUrl), body: property);
  }

  Future<void> updateProperty(int id, Map<String, dynamic> property) async {
    await http.put(Uri.parse('$apiUrl/$id'), body: property);
  }

  Future<void> deleteProperty(int id) async {
    await http.delete(Uri.parse('$apiUrl/$id'));
  }
}