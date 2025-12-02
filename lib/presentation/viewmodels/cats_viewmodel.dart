import 'package:flutter/foundation.dart';
import '../../domain/entities/cat_entity.dart';
import '../../domain/entities/breed_entity.dart';
import '../../domain/usecase/get_entities_usecase.dart';
import '../../data/repositories/cat_repository.dart';

class CatsViewModel extends ChangeNotifier {
  final CatRepository repository;
  late final GetEntitiesUseCase<CatEntity> getCatsUseCase;
  BreedEntity? selectedBreed;


  CatsViewModel(this.repository) {
    getCatsUseCase = GetEntitiesUseCase<CatEntity>(repository);
  }

  List<CatEntity> cats = [];
  List<BreedEntity> breeds = [];
  String? selectedBreedId;

  // Paginación
  int page = 0;
  final int limit = 10;
  bool loading = false;
  bool hasMore = true;

  // Cargar razas
  Future<void> loadBreeds() async {
    breeds = await repository.getBreeds();
    notifyListeners();
  }

  // Cargar gatos
  Future<void> loadCats({bool reset = false}) async {
    if (loading) return;

    if (reset) {
      page = 0;
      cats = [];
      hasMore = true;
      notifyListeners(); // limpia la lista en pantalla
    }

    if (!hasMore) return;

    loading = true;
    notifyListeners();

    final params = <String, String>{};
    if (selectedBreedId != null && selectedBreedId!.isNotEmpty) {
      params['breed_id'] = selectedBreedId!;
    }

    final newCats = await getCatsUseCase.call(
      page: page,
      limit: limit,
      params: params,
    );

    if (newCats.length < limit) hasMore = false;

    cats.addAll(newCats);
    page++;

    loading = false;
    notifyListeners();
  }
  

  // Cambiar raza
  void setBreed(String? breedId) {
  selectedBreedId = breedId;

  try {
    selectedBreed = breeds.firstWhere(
      (b) => b.id == breedId,
    );
  } catch (e) {
    selectedBreed = null; // si no existe la raza
  }

  loadCats(reset: true);
  notifyListeners();
}
}
