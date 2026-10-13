import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'beacon.dart';

class BeaconsNotifier extends Notifier<List<Beacon>> {
  @override
  List<Beacon> build() => const [
        Beacon(id: '1', emoji: '📚', activity: 'Studying', venue: 'General Library', seatsFree: 2),
        Beacon(id: '2', emoji: '☕', activity: 'Reading', venue: 'Cafe', seatsFree: 1),
      ];

  void add(Beacon beacon) => state = [...state, beacon];
}

final beaconsProvider =
    NotifierProvider<BeaconsNotifier, List<Beacon>>(BeaconsNotifier.new);