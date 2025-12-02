import '../../domain/entities/cat_entity.dart';
import '../../domain/entities/breed_entity.dart';
import '../datasources/cat_datasource.dart';
import '../models/cat_model.dart';
import 'base_repository.dart';

class CatRepository extends BaseRepository<CatEntity> {
  final CatDatasource datasource;

  CatRepository(this.datasource) : super(datasource);

  @override
  Future<List<CatEntity>> getAll({
    int page = 0,
    int limit = 10,
    Map<String, String>? params,
  }) async {
    final raw = await datasource.getAll(
      page: page,
      limit: limit,
      params: params,
    );

    return raw.map((json) => CatModel.fromJson(json)).toList();
  }

  Future<List<BreedEntity>> getBreeds() async {
    final raw = await datasource.getBreeds();
    return raw.map((e) => BreedEntity.fromJson(e)).toList();
  }
}
