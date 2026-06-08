import 'package:flutter/material.dart';
import 'peta_utama_page.dart';
import 'jalur_evakuasi_page.dart';
import 'semua_informasi_page.dart';
import '../../../auth/presentation/pages/login_page.dart';
import 'alerta_ai_page.dart';

class HomePage extends StatelessWidget {
  final String villageName;
  final String userName;
  
  const HomePage({super.key, required this.villageName, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 48,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Icon(Icons.location_on_outlined, color: Colors.black87),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'LOKASI SAAT INI', 
              style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 0.5)
            ),
            Row(
              children: [
                Text(
                  villageName, 
                  style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.black54),
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black87),
            onPressed: () {
              // Notification action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF4DAA1E), // Match the green color from image
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('SELAMAT PAGI,', style: TextStyle(color: Colors.white70, fontSize: 12, letterSpacing: 1.2, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text(userName, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.wb_sunny_outlined, color: Colors.yellow, size: 20),
                            const SizedBox(width: 6),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('29°C', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, height: 1.1)),
                                Text('Cerah', style: TextStyle(color: Colors.white, fontSize: 10, height: 1.1)),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              )
            ),

            // Quick Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionItem(
                    context,
                    icon: Icons.map_outlined,
                    label: 'Peta Rawan',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PetaUtamaPage()),
                      );
                    },
                  ),
                  _buildActionItem(
                    context,
                    icon: Icons.domain,
                    label: 'Posko',
                    onTap: () {
                      // Posko action
                    },
                  ),
                  _buildActionItem(
                    context,
                    icon: Icons.directions_run,
                    label: 'Jalur Evakuasi',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const JalurEvakuasiPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            const Divider(thickness: 1, color: Color(0xFFF5F5F5)),

            // Informasi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SemuaInformasiPage()),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text('Lihat Semua', style: TextStyle(color: Color(0xFF4DAA1E), fontSize: 12, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Main News Card
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.network(
                            'https://awsimages.detik.net.id/community/media/visual/2024/02/25/banjir-di-bandar-lampung_169.jpeg?w=1200', // Representative image of flood
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 180,
                                width: double.infinity,
                                color: Colors.grey[300],
                                child: const Icon(Icons.image_not_supported, color: Colors.grey),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Banjir di Bandar Lampung', 
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Peneliti sebut banjir di Bandar Lampung pasti terjadi, tapi dampaknya dapat dikurangi', 
                                style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.4)
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Klik untuk info selengkapnya...', 
                                style: TextStyle(fontSize: 12, color: Colors.grey[400])
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 80), // Space for FAB
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AlertaAIPage()),
          );
        },
        backgroundColor: const Color(0xFF4DAA1E),
        child: const Icon(Icons.smart_toy, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Icon(icon, color: const Color(0xFF4DAA1E), size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
