import 'package:flutter/material.dart';
import '../../domain/entities/climate.dart';
import '../../domain/usecases/get_climate_usecase.dart';

class ClimateViewmodel extends ChangeNotifier {
  final GetClimateUsecase getClimateUsecase;

  ClimateViewmodel(this.getClimateUsecase);

  Climate? weather;
  bool loading = false;
  String? error;

  int page = 0;
  int limit = 10;

  String search = "";

  List<int> get filteredIndexes {
    if (weather == null) return [];

    final total = weather!.times.length;

    final baseIndexes = List.generate(total, (i) => i);

    final filtered = baseIndexes.where((i) {
      final time = weather!.times[i].toLowerCase();
      final query = search.toLowerCase();
      return time.contains(query);
    }).toList();

    final maxPage = (filtered.length / limit).ceil() - 1;
    if (page > maxPage && maxPage >= 0) {
      page = maxPage;
    }

    final start = page * limit;
    final end = (start + limit > filtered.length)
        ? filtered.length
        : start + limit;

    if (start >= filtered.length) return [];

    return filtered.sublist(start, end);
  }

  Future<void> load(double lat, double lon) async {
    try {
      loading = true;
      notifyListeners();

      weather = await getClimateUsecase(lat, lon);

      page = 0;
      search = "";

      loading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      loading = false;
      notifyListeners();
    }
  }

  void setSearch(String value) {
    search = value;
    page = 0; 
    notifyListeners();
  }

  void nextPage() {
    final totalFiltered = filteredIndexes.length + (page * limit);
    final maxPage = ((weather?.times.length ?? 0) / limit).ceil() - 1;

    if (page < maxPage) {
      page++;
      notifyListeners();
    }
  }

  void prevPage() {
    if (page > 0) {
      page--;
      notifyListeners();
    }
  }
}
