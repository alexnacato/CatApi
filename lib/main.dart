import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/datasources/cat_datasource.dart';
import 'data/repositories/cat_repository.dart';
import 'presentation/viewmodels/cats_viewmodel.dart';
import 'presentation/routes/app_routes.dart';

void main() {
  final datasource = CatDatasource();
  final repository = CatRepository(datasource);

  runApp(MyApp(repository));
}

class MyApp extends StatelessWidget {
  final CatRepository repository;
  const MyApp(this.repository, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CatsViewModel(repository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Cat App",
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
