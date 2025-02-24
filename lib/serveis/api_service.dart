import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/persona.dart';

class ApiService {
  static const String baseUrl = 'https://caf63ae5dba54460a2f8.free.beeceptor.com/api/persones';

  static Future<List<Persona>> getPersones() async {
    final response = await http.get(Uri.parse('$baseUrl'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final persones = (data['message'] as Map<String, dynamic>).keys.toList();
      return persones as List<Persona>;
    } else {
      throw Exception('Failed to load breeds');
    }
  }

  static Future<List<String>> getPersonaById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<String>.from(data['message']);
    } else {
      throw Exception('Failed to load sub-breeds');
    }
  }

  Future<http.Response> postPersona(Persona persona) {
  return http.post(
    Uri.parse('$baseUrl'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(persona.toJson),
  );
}
}
