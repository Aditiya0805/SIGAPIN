import 'package:flutter/material.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Tandai dibaca',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          _buildNotificationItem(
            context,
            title: 'Peringatan Dini Banjir!',
            message: 'Potensi banjir di wilayah Sungai Citarum Hulu dalam 2 jam ke depan. Harap waspada.',
            time: '2 jam yang lalu',
            icon: Icons.warning_rounded,
            iconColor: Colors.orange,
            isUnread: true,
          ),
          _buildNotificationItem(
            context,
            title: 'Jalur Evakuasi Diperbarui',
            message: 'Jalur evakuasi menuju Posko Utama telah diperbarui. Silakan cek peta untuk detailnya.',
            time: '1 hari yang lalu',
            icon: Icons.map,
            iconColor: Colors.blue,
            isUnread: true,
          ),
          _buildNotificationItem(
            context,
            title: 'Cuaca Ekstrem',
            message: 'Hujan lebat disertai angin kencang diprediksi akan turun sore ini.',
            time: '2 hari yang lalu',
            icon: Icons.cloud_sharp,
            iconColor: Colors.grey[700]!,
            isUnread: false,
          ),
          _buildNotificationItem(
            context,
            title: 'Bantuan Logistik',
            message: 'Bantuan logistik telah tiba di Posko Balai Desa.',
            time: '3 hari yang lalu',
            icon: Icons.local_shipping,
            iconColor: Colors.green,
            isUnread: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context, {
    required String title,
    required String message,
    required String time,
    required IconData icon,
    required Color iconColor,
    required bool isUnread,
  }) {
    return Container(
      color: isUnread ? Colors.blue.withValues(alpha: 0.05) : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(
                    color: isUnread ? Colors.black87 : Colors.grey[600],
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
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
