import 'base_entity.dart';
import 'breed_entity.dart';

class CatEntity extends BaseEntity {
  final String id;
  final String url;
  final int width;
  final int height;
  final List<BreedEntity> breeds;

  CatEntity({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
    required this.breeds,
  });
}