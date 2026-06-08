import '../../domain/entities/emergency_report.dart';

class EmergencyReportModel extends EmergencyReport {
  EmergencyReportModel({
    required super.id,
    required super.reporterName,
    required super.reportType,
    required super.description,
    required super.latitude,
    required super.longitude,
    required super.timestamp,
    super.status,
    super.imageUrls,
  });

  factory EmergencyReportModel.fromEntity(EmergencyReport entity) {
    return EmergencyReportModel(
      id: entity.id,
      reporterName: entity.reporterName,
      reportType: entity.reportType,
      description: entity.description,
      latitude: entity.latitude,
      longitude: entity.longitude,
      timestamp: entity.timestamp,
      status: entity.status,
      imageUrls: entity.imageUrls,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reporterName': reporterName,
      'reportType': reportType,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
      'imageUrls': imageUrls,
    };
  }

  factory EmergencyReportModel.fromMap(Map<String, dynamic> map, String documentId) {
    return EmergencyReportModel(
      id: documentId,
      reporterName: map['reporterName'] ?? '',
      reportType: map['reportType'] ?? '',
      description: map['description'] ?? '',
      latitude: (map['latitude'] ?? 0.0).toDouble(),
      longitude: (map['longitude'] ?? 0.0).toDouble(),
      timestamp: map['timestamp'] != null ? DateTime.parse(map['timestamp']) : DateTime.now(),
      status: map['status'] ?? 'pending',
      imageUrls: map['imageUrls'] != null ? List<String>.from(map['imageUrls']) : null,
    );
  }
}
