import '../entities/climate.dart';
import '../../data/repositories/climate_repository_impl.dart';

class GetClimateUsecase {
  final ClimateRepositoryImpl repository;
  GetClimateUsecase(this.repository);

  Future<Climate> call(double lat, double lon){
    return repository.getClimate(lat, lon);
  }
}