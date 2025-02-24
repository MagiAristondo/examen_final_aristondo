import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://dog.ceo/api';

  static Future<List<String>> getBreeds() async {
    final response = await http.get(Uri.parse('$baseUrl/breeds/list/all'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final breeds = (data['message'] as Map<String, dynamic>).keys.toList();
      return breeds;
    } else {
      throw Exception('Failed to load breeds');
    }
  }

  // Nova funció per obtenir les sub-races
  static Future<List<String>> getSubBreeds(String breed) async {
    final response = await http.get(Uri.parse('$baseUrl/breed/$breed/list'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<String>.from(data['message']);
    } else {
      throw Exception('Failed to load sub-breeds');
    }
  }

  static Future<List<String>> getBreedImages(String breed) async {
    final response = await http.get(Uri.parse('$baseUrl/breed/$breed/images'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<String>.from(data['message']);
    } else {
      throw Exception('Failed to load breed images');
    }
  }

  static Future<String> getRandomBreedImage(String breed) async {
    final response =
        await http.get(Uri.parse('$baseUrl/breed/$breed/images/random'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'];
    } else {
      throw Exception('Failed to load random breed image');
    }
  }

  static Future<List<String>> getSubBreedImages(
      String breed, String subBreed) async {
    final String url = 'https://dog.ceo/api/breed/$breed/$subBreed/images';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<String>.from(data['message']);
    } else {
      throw Exception('Failed to load images for $subBreed of $breed');
    }
  }

  static Future<String> getRandomSubBreedImage(
      String breed, String subBreed) async {
    final response = await http.get(
      Uri.parse('$baseUrl/breed/$breed/$subBreed/images/random'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'];
    } else {
      throw Exception('Failed to load random sub-breed image');
    }
  }
}
