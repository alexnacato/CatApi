import 'dart:convert';
import 'package:http/http.dart' as http;
import 'base_datasource.dart';

class CatDatasource extends BaseDatasource<Map<String, dynamic>> {
  final String baseUrl = "https://api.thecatapi.com/v1/images/search";
  final String breedsUrl = "https://api.thecatapi.com/v1/breeds";
  final String apiKey = ""; // opcional

  @override
  Future<List<Map<String, dynamic>>> getAll({
    int page = 0,
    int limit = 10,
    Map<String, String>? params,
  }) async {

    final query = {
      "limit": "$limit",
      "page": "$page",
      "order": "Desc",
      if (params?["breed_id"]?.isNotEmpty ?? false)
        "breed_ids": params!["breed_id"]!,
    };

    final uri = Uri.parse(baseUrl).replace(queryParameters: query);

    final res = await http.get(
      uri,
      headers: apiKey.isNotEmpty ? {"x-api-key": apiKey} : {},
    );

    if (res.statusCode != 200) {
      throw Exception("Error al obtener imágenes: ${res.statusCode}");
    }

    return List<Map<String, dynamic>>.from(json.decode(res.body));
  }


  /// Obtener lista de razas
  Future<List<Map<String, dynamic>>> getBreeds() async {
    final res = await http.get(
      Uri.parse(breedsUrl),
      headers: apiKey.isNotEmpty ? {"x-api-key": apiKey} : {},
    );

    if (res.statusCode != 200) {
      throw Exception("Error al obtener razas: ${res.statusCode}");
    }

    return List<Map<String, dynamic>>.from(json.decode(res.body));
  }
}
