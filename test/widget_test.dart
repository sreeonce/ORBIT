import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbit/features/beacons/beacon_list_screen.dart';

void main() {
  testWidgets('shows seeded beacons', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: BeaconListScreen())),
    );
    expect(find.text('Studying'), findsOneWidget);
    expect(find.text('Reading'), findsOneWidget);
  });
}