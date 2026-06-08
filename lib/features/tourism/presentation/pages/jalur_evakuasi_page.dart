import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class JalurEvakuasiPage extends StatefulWidget {
  const JalurEvakuasiPage({super.key});

  @override
  State<JalurEvakuasiPage> createState() => _JalurEvakuasiPageState();
}

class _JalurEvakuasiPageState extends State<JalurEvakuasiPage> {
  final MapController _mapController = MapController();

  // Koordinat lokasi saat ini (simulasi)
  final LatLng _currentLocation = const LatLng(-6.914744, 107.609810);
  
  // Koordinat titik kumpul / posko (simulasi)
  final LatLng _safeZone = const LatLng(-6.905000, 107.615000);

  // Jalur (rute) dari lokasi saat ini ke posko
  final List<LatLng> _routePoints = [
    const LatLng(-6.914744, 107.609810),
    const LatLng(-6.912000, 107.610000),
    const LatLng(-6.910000, 107.612000),
    const LatLng(-6.908000, 107.614000),
    const LatLng(-6.905000, 107.615000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Jalur Evakuasi',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Flutter Map
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(-6.910000, 107.612000), // Tengah rute
              initialZoom: 14.5,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              // Jalur Evakuasi
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _routePoints,
                    color: Colors.blue[600]!,
                    strokeWidth: 6.0,
                  ),
                ],
              ),
              // Marker Lokasi dan Tujuan
              MarkerLayer(
                markers: [
                  // Lokasi Saat Ini
                  Marker(
                    point: _currentLocation,
                    width: 40,
                    height: 40,
                    child: const _MapMarker(
                      icon: Icons.person_pin_circle,
                      color: Colors.orange,
                    ),
                  ),
                  // Titik Aman / Posko
                  Marker(
                    point: _safeZone,
                    width: 50,
                    height: 50,
                    child: const _MapMarker(
                      icon: Icons.shield,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Tombol Fokus Rute (Kanan Atas)
          Positioned(
            top: 16,
            right: 16,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              child: const Icon(Icons.my_location, color: Colors.black87),
              onPressed: () {
                _mapController.move(_currentLocation, 15.0);
              },
            ),
          ),

          // Info Panel (Bawah)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.check_circle, color: Colors.green),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Jalur Aman Ditemukan',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Menuju Posko Balai Desa',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildInfoColumn(Icons.directions_walk, 'Jarak', '1.2 km'),
                        Container(width: 1, height: 40, color: Colors.grey[300]),
                        _buildInfoColumn(Icons.timer, 'Waktu', '15 Menit'),
                        Container(width: 1, height: 40, color: Colors.grey[300]),
                        _buildInfoColumn(Icons.shield_outlined, 'Status', 'Aman'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Mulai Navigasi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16), // SafeArea
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey[600], size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }
}

class _MapMarker extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _MapMarker({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        Container(
          width: 2,
          height: 6,
          color: Colors.black87,
        ),
      ],
    );
  }
}
