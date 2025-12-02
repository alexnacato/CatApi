import '../../domain/entities/base_entity.dart';
import '../../data/repositories/base_repository.dart';

class GetEntitiesUseCase<T extends BaseEntity> {
  final BaseRepository<T> repository;
  GetEntitiesUseCase(this.repository);

  Future<List<T>> call({int page = 0, int limit = 10, Map<String,String>? params}) {
    return repository.getAll(page: page, limit: limit, params: params);
  }
}
