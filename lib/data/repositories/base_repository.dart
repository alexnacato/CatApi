import '../datasources/base_datasource.dart';
import '../../domain/entities/base_entity.dart';

abstract class BaseRepository<T extends BaseEntity> {
  final BaseDatasource datasource;
  BaseRepository(this.datasource);

  Future<List<T>> getAll({int page = 0, int limit = 10, Map<String,String>? params});
}
