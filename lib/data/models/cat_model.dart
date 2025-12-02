import '../../domain/entities/cat_entity.dart';
import '../../domain/entities/breed_entity.dart';

class CatModel extends CatEntity {
  CatModel({
    required super.id,
    required super.url,
    required super.width,
    required super.height,
    required super.breeds,
  });

  factory CatModel.fromJson(Map<String, dynamic> json) {
    final breeds = <BreedEntity>[];

    if (json['breeds'] != null) {
      for (var b in json['breeds']) {
        breeds.add(BreedEntity.fromJson(b));
      }
    }

    return CatModel(
      id: json['id'] ?? '',
      url: json['url'] ?? '',
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      breeds: breeds,
    );
  }
}