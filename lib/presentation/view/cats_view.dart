import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/cats_viewmodel.dart';

class CatsView extends StatefulWidget {
  const CatsView({super.key});

  @override
  State<CatsView> createState() => _CatsViewState();
}

class _CatsViewState extends State<CatsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final vm = context.read<CatsViewModel>();
    vm.loadBreeds();
    vm.loadCats();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 50) {
        vm.loadCats();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CatsViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("APi de Gatos")),
      body: Column(
        children: [
          // Dropdown de razas
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: vm.selectedBreedId,
              hint: const Text("Selecciona una raza"),
              isExpanded: true,
              items: vm.breeds.map((b) {
                return DropdownMenuItem(
                  value: b.id,
                  child: Text(b.name),
                );
              }).toList(),
              onChanged: vm.setBreed,
            ),
          ),

          // ⭐ Información general de la raza
          if (vm.selectedBreed != null)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vm.selectedBreed!.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text("Origen: ${vm.selectedBreed!.origin}"),
                  const SizedBox(height: 4),
                  Text("Temperamento: ${vm.selectedBreed!.temperament}"),
                  const SizedBox(height: 4),
                  Text("Energía: ${vm.selectedBreed!.energyLevel} / 5"),
                  
                ],
              ),
            ),

          const SizedBox(height: 10),

          // Lista de gatos
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: vm.cats.length + (vm.loading ? 1 : 0),
              itemBuilder: (_, index) {
                if (index == vm.cats.length) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final cat = vm.cats[index];

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Image.network(
                    cat.url,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
