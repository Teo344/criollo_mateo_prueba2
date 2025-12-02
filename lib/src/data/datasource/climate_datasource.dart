import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/climate_model.dart';

class ClimateDatasource {
  
  Future<ClimateModel> fetchWeather(double lat, double lon) async {
    final url = Uri.parse(
      "https://api.open-meteo.com/v1/forecast?"
      "latitude=$lat&longitude=$lon&hourly=temperature_2m",
    );

    final res = await http.get(url);

    if (res.statusCode == 200) {
      return ClimateModel.fromJson(json.decode(res.body));
    } else {
      throw Exception("Error al cargar datos");
    }
  }

}