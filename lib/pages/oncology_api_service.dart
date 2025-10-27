import 'package:dio/dio.dart';
import 'dart:convert';

class OncologyApiService {
  final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> fetchCancerStatistics() async {
    const String url = 'https://observatorio.oncologia.org.br/api/estimativas';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        dynamic data = response.data;

        if (data is String) {
          data = json.decode(data);
        }

        if (data is Map<String, dynamic>) {
          return [data];
        }

        if (data is List) {
          return List<Map<String, dynamic>>.from(data);
        }

        throw Exception('Formato inesperado de resposta da API.');
      } else {
        throw Exception('Erro HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao conectar à API: $e');
    }
  }
}
