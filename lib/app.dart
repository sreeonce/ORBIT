import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/beacons/beacon_list_screen.dart';

class OrbitApp extends StatelessWidget {
  const OrbitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ORBIT',
      theme: AppTheme.light(),
      home: const BeaconListScreen(),
    );
  }
}