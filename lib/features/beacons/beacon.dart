class Beacon {
  const Beacon({
    required this.id,
    required this.emoji,
    required this.activity,
    required this.venue,
    required this.seatsFree,
  });

  final String id;
  final String emoji;
  final String activity;
  final String venue;
  final int seatsFree;
}