import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TodoProvider.dart';
import 'package:to_do_list/ListsPage.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<TodoProvider>();
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(p.currentList.name),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ListsPage()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () => p.clearCurrentList(),
          ),
        ],
      ),

      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sfondo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),

            //calcolo percentuale imm
            Image.asset(
              p.flowerImage,
              height: 160,
            ),

            const SizedBox(height: 10),
            Text(
              '${p.currentEfficiency.toStringAsFixed(0)}%',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: 'Nuovo task',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (controller.text.trim().isNotEmpty) {
                        p.addItem(controller.text.trim());
                        controller.clear();
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: p.currentList.items.length,
                itemBuilder: (_, index) {
                  final item = p.currentList.items[index];
                  return Card(
                    child: ListTile(
                      leading: item.done
                          ? Image.asset(
                        'assets/images/a.png',
                        width: 32,
                      )
                          : Checkbox(
                        value: item.done,
                        onChanged: (_) {
                          p.toggleItem(index);
                        },
                      ),
                      title: Text(
                        item.title,
                        style: TextStyle(
                          decoration: item.done
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => p.removeItem(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}