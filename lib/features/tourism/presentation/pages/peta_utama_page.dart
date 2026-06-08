import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PetaUtamaPage extends StatefulWidget {
  final bool showBackButton;

  const PetaUtamaPage({super.key, this.showBackButton = true});

  @override
  State<PetaUtamaPage> createState() => _PetaUtamaPageState();
}

class _PetaUtamaPageState extends State<PetaUtamaPage> {
  final MapController _mapController = MapController();

  // Koordinat tengah peta (misalnya di suatu daerah rawan)
  final LatLng _center = const LatLng(-6.914744, 107.609810); // Contoh: Bandung

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: widget.showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: const Text(
          'Peta Rawan Bencana',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Flutter Map
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              // Polygon untuk area rawan (merah/oranye)
              PolygonLayer(
                polygons: [
                  Polygon(
                    points: [
                      LatLng(_center.latitude + 0.01, _center.longitude - 0.01),
                      LatLng(_center.latitude + 0.02, _center.longitude + 0.01),
                      LatLng(_center.latitude + 0.01, _center.longitude + 0.03),
                      LatLng(_center.latitude - 0.01, _center.longitude + 0.02),
                      LatLng(_center.latitude - 0.015, _center.longitude - 0.005),
                    ],
                    color: Colors.red.withValues(alpha: 0.4),
                    borderColor: Colors.red,
                    borderStrokeWidth: 2,
                  ),
                  Polygon(
                    points: [
                      LatLng(_center.latitude + 0.015, _center.longitude - 0.015),
                      LatLng(_center.latitude + 0.025, _center.longitude + 0.005),
                      LatLng(_center.latitude + 0.015, _center.longitude + 0.035),
                      LatLng(_center.latitude - 0.015, _center.longitude + 0.025),
                      LatLng(_center.latitude - 0.02, _center.longitude - 0.01),
                    ],
                    color: Colors.orange.withValues(alpha: 0.3),
                    borderColor: Colors.orange,
                    borderStrokeWidth: 1,
                  ),
                ],
              ),
              // Marker Layer
              MarkerLayer(
                markers: [
                  // Banjir (Biru)
                  _buildMarker(LatLng(_center.latitude, _center.longitude), Colors.blue, Icons.water_drop),
                  _buildMarker(LatLng(_center.latitude - 0.005, _center.longitude + 0.01), Colors.blue, Icons.water_drop),
                  // Tanah Longsor (Hijau)
                  _buildMarker(LatLng(_center.latitude + 0.01, _center.longitude - 0.005), Colors.green, Icons.landscape),
                  _buildMarker(LatLng(_center.latitude - 0.01, _center.longitude + 0.02), Colors.green, Icons.landscape),
                  // Gempa Bumi (Merah)
                  _buildMarker(LatLng(_center.latitude + 0.005, _center.longitude - 0.01), Colors.red, Icons.broken_image),
                  // Tanah Longsor Oranye
                  _buildMarker(LatLng(_center.latitude + 0.015, _center.longitude + 0.01), Colors.orange, Icons.warning_amber),
                ],
              ),
            ],
          ),

          // Floating Action Buttons di Kanan Atas
          Positioned(
            top: 16,
            right: 16,
            child: Column(
              children: [
                _buildMapActionButton(Icons.layers),
                const SizedBox(height: 8),
                _buildMapActionButton(Icons.remove),
                const SizedBox(height: 8),
                _buildMapActionButton(Icons.add_box), // Ikon poligon
              ],
            ),
          ),

          // Legenda Peta di Bawah
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
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Legenda Peta',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.chevron_right, color: Colors.grey[600]),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildLegendItem(Colors.blue, 'Banjir'),
                        const SizedBox(width: 12),
                        _buildLegendItem(Colors.green, 'Tanah Longsor'),
                        const SizedBox(width: 12),
                        _buildLegendItem(Colors.orange, 'Tanah Longsor'),
                        const SizedBox(width: 12),
                        _buildLegendItem(Colors.red, 'Gempa Bumi'),
                        const SizedBox(width: 12),
                        _buildLegendItem(Colors.blue[700]!, 'Tsunami'),
                      ],
                    ),
                  ),
                  // Tambahkan jarak aman untuk bottom navigation bar jika dipanggil dari tab
                  if (!widget.showBackButton) const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Marker _buildMarker(LatLng point, Color color, IconData icon) {
    return Marker(
      point: point,
      width: 40,
      height: 40,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
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
            child: Icon(icon, color: Colors.white, size: 16),
          ),
          // Ekor penanda (segitiga kecil di bawah lingkaran)
          Container(
            width: 2,
            height: 6,
            color: Colors.black87,
          ),
        ],
      ),
    );
  }

  Widget _buildMapActionButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black87),
        onPressed: () {},
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }
}
