import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/emergency/data/models/emergency_report_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addEmergencyReport(EmergencyReportModel report) async {
    try {
      // Jika id kosong, biarkan Firestore membuatkan ID (auto-generate)
      if (report.id.isNotEmpty) {
        await _firestore
            .collection('emergency_reports')
            .doc(report.id)
            .set(report.toMap());
      } else {
        await _firestore
            .collection('emergency_reports')
            .add(report.toMap());
      }
    } catch (e) {
      throw Exception('Gagal menambahkan laporan darurat: $e');
    }
  }
}
