import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/data/datasource/climate_datasource.dart';
import 'src/data/repositories/climate_repository_impl.dart';
import 'src/domain/usecases/get_climate_usecase.dart';
import 'src/presentation/viewmodels/climate_viewmodel.dart';

import 'src/presentation/routes/app_routes.dart';

void main() {
  final datasource = ClimateDatasource();
  final repository = ClimateRepositoryImpl(datasource);
  final usecase = GetClimateUsecase(repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ClimateViewmodel(usecase),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.climate,
        routes: AppRoutes.routes,
      ),
    ),
  );
}
