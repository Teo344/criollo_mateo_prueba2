import '../../domain/entities/climate.dart';

class ClimateModel extends Climate{
  ClimateModel({required super.times, required super.temperatures});

  factory ClimateModel.fromJson(Map<String, dynamic> json) {
    return ClimateModel(
      times: List<String>.from(json["hourly"]["time"]),
      temperatures: List<double>.from(json["hourly"]["temperature_2m"]),
    );
  }
}