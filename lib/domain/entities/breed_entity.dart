class BreedEntity {
  final String id;
  final String name;
  final String temperament;
  final String origin;
  final int energyLevel;

  BreedEntity({
    required this.id,
    required this.name,
    required this.temperament,
    required this.origin,
    required this.energyLevel,
  });

  factory BreedEntity.fromJson(Map<String, dynamic> json) {
    return BreedEntity(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      temperament: json['temperament'] ?? '',
      origin: json['origin'] ?? '',
      energyLevel: json['energy_level'] ?? 0,
    );
  }
}
