import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'beacon.dart';
import 'beacons_provider.dart';

class BeaconListScreen extends ConsumerWidget {
  const BeaconListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final beacons = ref.watch(beaconsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('ORBIT')),
      body: ListView(
        children: [
          for (final b in beacons)
            ListTile(
              leading: Text(b.emoji, style: const TextStyle(fontSize: 28)),
              title: Text(b.activity),
              subtitle: Text(b.venue),
              trailing: Text('${b.seatsFree} free'),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(beaconsProvider.notifier).add(
              Beacon(
                id: DateTime.now().toString(),
                emoji: '💻',
                activity: 'Coding',
                venue: 'Central Library',
                seatsFree: 1,
              ),
            ),
        child: const Icon(Icons.add),
      ),
    );
  }
}