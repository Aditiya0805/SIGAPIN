class EmergencyReport {
  final String id;
  final String reporterName;
  final String reportType;
  final String description;
  final double latitude;
  final double longitude;
  final DateTime timestamp;
  final String status;
  final List<String>? imageUrls;

  EmergencyReport({
    required this.id,
    required this.reporterName,
    required this.reportType,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    this.status = 'pending',
    this.imageUrls,
  });
}
