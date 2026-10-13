import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbit/app.dart';

void main() {
  testWidgets('shows seeded beacons', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: OrbitApp()));
    expect(find.text('Studying'), findsOneWidget);
    expect(find.text('Reading'), findsOneWidget);
  });
}