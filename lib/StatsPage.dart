import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TodoProvider.dart';


class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<TodoProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Statistiche')),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/s.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // FUMETTO TUTTE LE LISTE
                  const Text(
                    'Tutte le liste',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Totali: ${p.totalCount}'),
                  Text('Completati: ${p.doneCount}'),
                  LinearProgressIndicator(value: p.efficiency / 100),
                  Text(
                      'Efficienza globale: ${p.efficiency.toStringAsFixed(1)}%'),
                  const Divider(height: 30, color: Colors.grey),
                  // FUMETTO LISTA SELEZIONATA
                  Text(
                    'Lista: ${p.currentList.name}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Task: ${p.currentTotal}'),
                  LinearProgressIndicator(value: p.currentEfficiency / 100),
                  Text(
                      'Efficienza lista: ${p.currentEfficiency.toStringAsFixed(1)}%'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}