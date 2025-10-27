import '../db/propriedades_dao.dart';
import '../domain/propriedade.dart';

class FakeApiService {
  final PropriedadesDao _dao = PropriedadesDao();

  /// Simula um endpoint GET local
  Future<List<Map<String, dynamic>>> fetchCreatorsFromDatabase() async {
    final List<Propriedade> propriedades = await _dao.listarPropriedades();

    // Transforma os objetos em formato JSON
    return propriedades.map((p) => {
      'id': p.id,
      'image': p.image ?? '',
      'nome': p.nome ?? 'Desconhecido',
    }).toList();
  }
}
