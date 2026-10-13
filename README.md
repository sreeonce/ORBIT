# ORBIT

Low-stakes parallel-play co-working app. Flutter, Firebase, Riverpod.

## State management rules
1. Riverpod only. No setState for shared data, no Provider, Bloc or GetX.
2. Use Notifier, AsyncNotifier and StreamProvider. No StateNotifier or ChangeNotifier providers.
3. Firebase calls live in repository classes, never in widgets.
4. Widgets only display state and call notifier methods.
5. ref.watch in build(), ref.read in callbacks.
6. All colors and fonts live in core/theme/app_theme.dart.