class EmergencySignal {
  final String id;
  final double latitude;
  final double longitude;
  final int batteryLevel;
  final DateTime timestamp;
  final bool isSynced;

  EmergencySignal({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.batteryLevel,
    required this.timestamp,
    this.isSynced = false,
  });
}
