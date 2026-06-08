import 'package:flutter/material.dart';

class SemuaInformasiPage extends StatelessWidget {
  const SemuaInformasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Semua Informasi',
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildInfoCard(
            context,
            title: 'Peringatan Dini Banjir - Sungai Citarum Hulu',
            time: '2 jam yang lalu',
            icon: Icons.warning_amber_rounded,
            iconColor: Colors.orange,
            bgColor: Colors.orange[50]!,
          ),
          _buildInfoCard(
            context,
            title: 'Cuaca Ekstrem: Hujan Lebat Disertai Angin Kencang',
            time: '5 jam yang lalu',
            icon: Icons.cloud_sharp,
            iconColor: Colors.blue,
            bgColor: Colors.blue[50]!,
          ),
          _buildInfoCard(
            context,
            title: 'Jalan Desa Ditutup Sementara Karena Perbaikan',
            time: '1 hari yang lalu',
            icon: Icons.construction,
            iconColor: Colors.grey[700]!,
            bgColor: Colors.grey[200]!,
          ),
          _buildInfoCard(
            context,
            title: 'Pembagian Logistik di Posko Utama',
            time: '1 hari yang lalu',
            icon: Icons.inventory,
            iconColor: Colors.green,
            bgColor: Colors.green[50]!,
          ),
          _buildInfoCard(
            context,
            title: 'Himbauan: Jauhi Area Tebing Curam',
            time: '2 hari yang lalu',
            icon: Icons.landscape,
            iconColor: Colors.brown,
            bgColor: Colors.brown[50]!,
          ),
          _buildInfoCard(
            context,
            title: 'Nomor Darurat Penting Telah Diperbarui',
            time: '3 hari yang lalu',
            icon: Icons.contact_phone,
            iconColor: Colors.teal,
            bgColor: Colors.teal[50]!,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required String time,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
