import 'package:flutter/material.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/services/battery_service.dart';
import '../../../../core/services/firestore_service.dart';
import '../../data/models/emergency_report_model.dart';

class SosPage extends StatefulWidget {
  const SosPage({super.key});

  @override
  State<SosPage> createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> with TickerProviderStateMixin {
  late AnimationController _pressController;
  int _pressCounter = 0;
  bool _isSending = false;
  
  final BatteryService _batteryService = BatteryService();
  final LocationService _locationService = LocationService();
  final FirestoreService _firestoreService = FirestoreService();
  String _batteryLevel = '--%';
  String _locationStatus = 'Mencari...';
  Color _locationColor = Colors.orange;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _initServices();
  }

  Future<void> _initServices() async {
    final battery = await _batteryService.getBatteryLevel();
    if (mounted) {
      setState(() {
        _batteryLevel = battery != -1 ? '$battery%' : 'Error';
      });
    }
    
    final locationResult = await _locationService.getCurrentPosition();
    if (mounted) {
      setState(() {
        locationResult.fold(
          (failure) {
            _locationStatus = 'Gagal';
            _locationColor = Colors.red;
          },
          (position) {
            _locationStatus = 'Akurat';
            _locationColor = Colors.green;
          },
        );
      });
    }
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  void _handleSosPress() {
    _pressCounter++;

    _pressController.reset();
    _pressController.forward().then((_) {
      if (_pressCounter >= 1) {
        _showSosConfirmation();
      }
    });
  }

  void _handleSosRelease() {
    _pressCounter = 0;
    _pressController.reset();
  }

  void _showSosConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi SOS'),
        content: const Text(
          'Anda akan mengirimkan sinyal darurat beserta lokasi Anda ke petugas desa. Lanjutkan?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _sendSos();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[700],
            ),
            child: const Text('Kirim SOS', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _sendSos() async {
    setState(() => _isSending = true);

    // Get latest location before sending
    final locationResult = await _locationService.getCurrentPosition();
    final battery = await _batteryService.getBatteryLevel();

    double lat = 0.0;
    double lng = 0.0;
    locationResult.fold(
      (failure) {},
      (position) {
        lat = position.latitude;
        lng = position.longitude;
      },
    );

    final report = EmergencyReportModel(
      id: '',
      reporterName: 'Warga',
      reportType: 'SOS Darurat',
      description: 'Sinyal SOS dikirim. Baterai: ${battery != -1 ? battery : '--'}%',
      latitude: lat,
      longitude: lng,
      timestamp: DateTime.now(),
    );

    try {
      await _firestoreService.addEmergencyReport(report);
    } catch (e) {
      debugPrint('Error sending SOS: $e');
    }

    if (mounted) {
      setState(() => _isSending = false);
      
      String locationMsg = locationResult.isRight() ? 'Lokasi berhasil dilampirkan.' : 'Gagal melampirkan lokasi presisi.';

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('SOS Terkirim!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Sinyal darurat Anda telah diterima oleh petugas desa.'),
              const SizedBox(height: 8),
              Text(locationMsg, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Baterai perangkat: ${battery != -1 ? battery : '--'}%'),
              const SizedBox(height: 16),
              const Text('Harap tetap tenang dan segera cari tempat yang aman.'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[700]),
              child: const Text('Tutup', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }
  }

  void _showReportDialog(String reportType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Lapor $reportType'),
        content: Text('Anda akan membuat laporan terkait $reportType. Apakah Anda ingin melampirkan foto?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(child: CircularProgressIndicator()),
              );

              final locationResult = await _locationService.getCurrentPosition();
              double lat = 0.0;
              double lng = 0.0;
              locationResult.fold(
                (failure) {},
                (position) {
                  lat = position.latitude;
                  lng = position.longitude;
                },
              );

              final report = EmergencyReportModel(
                id: '',
                reporterName: 'Warga',
                reportType: reportType,
                description: 'Laporan warga terkait $reportType.',
                latitude: lat,
                longitude: lng,
                timestamp: DateTime.now(),
              );

              try {
                await _firestoreService.addEmergencyReport(report);
                if (context.mounted) {
                  Navigator.pop(context); // Tutup loading
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Laporan $reportType berhasil dikirim ke database!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  Navigator.pop(context); // Tutup loading
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Gagal mengirim laporan $reportType: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
            child: const Text('Lanjutkan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Laporan & Darurat',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Darurat Section (SOS)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Keadaan Darurat?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tahan tombol di bawah selama 3 detik untuk mengirimkan sinyal SOS beserta lokasi Anda.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // SOS Button
                  GestureDetector(
                    onLongPressStart: (_) => _handleSosPress(),
                    onLongPressEnd: (_) => _handleSosRelease(),
                    child: AnimatedBuilder(
                      animation: _pressController,
                      builder: (context, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            // Progress ring
                            SizedBox(
                              width: 160,
                              height: 160,
                              child: CircularProgressIndicator(
                                value: _pressController.value,
                                strokeWidth: 8,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.red[700]!,
                                ),
                                backgroundColor: Colors.red[100],
                              ),
                            ),
                            // SOS Button
                            Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                color: _isSending ? Colors.grey : Colors.red[600],
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withValues(alpha: 0.3),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: _isSending
                                  ? const SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : const Text(
                                      'SOS',
                                      style: TextStyle(
                                        fontSize: 36,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                      ),
                                    ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Status Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatusItem(Icons.wifi, 'Online', Colors.green),
                      _buildStatusItem(Icons.location_on, _locationStatus, _locationColor),
                      _buildStatusItem(Icons.battery_full, _batteryLevel, Colors.green),
                    ],
                  ),
                ],
              ),
            ),
            
            // Laporan Section
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Buat Laporan Baru',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Grid Pilihan Laporan
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.1,
                    children: [
                      _buildReportOption(
                        title: 'Banjir',
                        icon: Icons.water_drop,
                        color: Colors.blue,
                        onTap: () => _showReportDialog('Banjir'),
                      ),
                      _buildReportOption(
                        title: 'Tanah Longsor',
                        icon: Icons.landscape,
                        color: Colors.brown,
                        onTap: () => _showReportDialog('Tanah Longsor'),
                      ),
                      _buildReportOption(
                        title: 'Kebakaran',
                        icon: Icons.local_fire_department,
                        color: Colors.orange,
                        onTap: () => _showReportDialog('Kebakaran'),
                      ),

                      _buildReportOption(
                        title: 'Lainnya',
                        icon: Icons.more_horiz,
                        color: Colors.teal,
                        onTap: () => _showReportDialog('Lainnya'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusItem(IconData icon, String text, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildReportOption({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
