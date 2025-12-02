abstract class BaseDatasource<T> {
  Future<List<Map<String, dynamic>>> getAll({
    int page = 0,
    int limit = 10,
    Map<String, String>? params,
  });
}
