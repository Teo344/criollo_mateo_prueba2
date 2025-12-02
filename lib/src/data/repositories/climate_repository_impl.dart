import '../../domain/entities/climate.dart';
import '../datasource/climate_datasource.dart';

class ClimateRepositoryImpl {
  final ClimateDatasource datasource;
  ClimateRepositoryImpl(this.datasource);

  Future<Climate> getClimate(double lat, double lon) async{
    return datasource.fetchWeather(lat, lon);
  }
}