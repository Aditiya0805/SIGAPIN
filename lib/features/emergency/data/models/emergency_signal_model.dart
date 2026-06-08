import '../../domain/entities/emergency_signal.dart';

class EmergencySignalModel {
  static const String tableName = 'emergency_signals';

  final int? id; // SQLite auto-increment id
  final String signalId; // UUID or string id
  final double latitude;
  final double longitude;
  final int batteryLevel;
  final DateTime timestamp;
  final bool isSynced;

  EmergencySignalModel({
    this.id,
    required this.signalId,
    required this.latitude,
    required this.longitude,
    required this.batteryLevel,
    required this.timestamp,
    required this.isSynced,
  });

  factory EmergencySignalModel.fromEntity(EmergencySignal entity) {
    return EmergencySignalModel(
      signalId: entity.id,
      latitude: entity.latitude,
      longitude: entity.longitude,
      batteryLevel: entity.batteryLevel,
      timestamp: entity.timestamp,
      isSynced: entity.isSynced,
    );
  }

  EmergencySignal toEntity() {
    return EmergencySignal(
      id: signalId,
      latitude: latitude,
      longitude: longitude,
      batteryLevel: batteryLevel,
      timestamp: timestamp,
      isSynced: isSynced,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'signalId': signalId,
      'latitude': latitude,
      'longitude': longitude,
      'batteryLevel': batteryLevel,
      'timestamp': timestamp.toIso8601String(),
      'isSynced': isSynced ? 1 : 0,
    };
  }

  factory EmergencySignalModel.fromMap(Map<String, dynamic> map) {
    return EmergencySignalModel(
      id: map['id'],
      signalId: map['signalId'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      batteryLevel: map['batteryLevel'],
      timestamp: DateTime.parse(map['timestamp']),
      isSynced: map['isSynced'] == 1,
    );
  }

  static String createTable() {
    return '''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        signalId TEXT UNIQUE NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        batteryLevel INTEGER NOT NULL,
        timestamp TEXT NOT NULL,
        isSynced INTEGER NOT NULL DEFAULT 0
      )
    ''';
  }
}
