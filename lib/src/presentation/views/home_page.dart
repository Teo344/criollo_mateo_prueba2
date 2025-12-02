import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/climate_viewmodel.dart';

class ClimatePage extends StatelessWidget {
  const ClimatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ClimateViewmodel>();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "OpenMeteo Viewer",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          /// ------------------------------------------------------------
          /// SECCIÓN SUPERIOR DECORADA
          /// ------------------------------------------------------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF7F52FF), Color(0xFFB897FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(26),
                bottomRight: Radius.circular(26),
              ),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Seleccione la ciudad",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonFormField<String>(
                    value: "Guayaquil",
                    decoration: const InputDecoration(border: InputBorder.none),
                    items: const [
                      DropdownMenuItem(
                          value: "Guayaquil", child: Text("Guayaquil")),
                      DropdownMenuItem(value: "Quito", child: Text("Quito")),
                      DropdownMenuItem(value: "Cuenca", child: Text("Cuenca")),
                    ],
                    onChanged: (city) {
                      if (city == "Guayaquil") vm.load(-2.17, -79.92);
                      if (city == "Quito") vm.load(-0.19, -78.50);
                      if (city == "Cuenca") vm.load(-2.90, -79.00);
                    },
                  ),
                ),

                const SizedBox(height: 14),

                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Buscar por fecha/hora",
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: vm.setSearch,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// ------------------------------------------------------------
          /// CONTENIDO PRINCIPAL
          /// ------------------------------------------------------------
          Expanded(
            child: vm.loading
                ? const Center(child: CircularProgressIndicator())
                : vm.weather == null
                    ? const Center(
                        child: Text(
                          "Seleccione una ciudad",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      )
                    : const _WeatherList(),
          ),

          /// ------------------------------------------------------------
          /// PAGINACIÓN BONITA
          /// ------------------------------------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: vm.page > 0 ? vm.prevPage : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple.shade400,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Anterior"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: vm.filteredIndexes.length == vm.limit
                        ? vm.nextPage
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple.shade400,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Siguiente"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WeatherList extends StatelessWidget {
  const _WeatherList({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ClimateViewmodel>();
    final indexes = vm.filteredIndexes;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: indexes.length,
      itemBuilder: (context, i) {
        final idx = indexes[i];
        final time = vm.weather!.times[idx];
        final temp = vm.weather!.temperatures[idx];

        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(14),
            child: ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple.shade100,
                child: const Icon(Icons.thermostat),
              ),
              title: Text(
                time,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                "${temp.toStringAsFixed(1)} °C",
                style: TextStyle(
                    fontSize: 15, color: Colors.deepPurple.shade700),
              ),
            ),
          ),
        );
      },
    );
  }
}
