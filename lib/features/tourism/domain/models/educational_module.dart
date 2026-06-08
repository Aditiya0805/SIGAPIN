class EducationalModule {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final String difficulty; // Beginner, Intermediate, Advanced
  final int duration; // in minutes
  final List<String> topics;

  const EducationalModule({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.difficulty,
    required this.duration,
    required this.topics,
  });
}

final List<EducationalModule> mockEducationalModules = [
  const EducationalModule(
    id: '1',
    title: 'Persiapan Menghadapi Gempa Bumi',
    description:
        'Pelajari cara mempersiapkan diri dan keluarga menghadapi gempa bumi. Termasuk tanda-tanda awal, teknik selamat diri di berbagai lokasi (rumah, kantor, mobil), dan perlengkapan darurat yang harus disiapkan. Modul ini juga mencakup prosedur evakuasi dan cara memberikan pertolongan pertama pada korban.',
    imageUrl:
        'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?q=80&w=600&auto=format&fit=crop',
    category: 'Gempa Bumi',
    difficulty: 'Pemula',
    duration: 15,
    topics: ['Tanda-tanda Awal Gempa', 'Teknik Selamat Diri', 'Kit Darurat Keluarga', 'Prosedur Berkumpul'],
  ),
  const EducationalModule(
    id: '2',
    title: 'Tanggap Darurat Banjir',
    description:
        'Panduan lengkap menangani banjir mulai dari pencegahan, pengenalan daerah rawan, persiapan keluarga, hingga teknik evakuasi yang aman. Pelajari cara mengidentifikasi area genangan, menyiapkan tas darurat, dan menyelamatkan barang-barang berharga. Modul ini juga mencakup pertolongan pertama untuk korban banjir dan upaya pemulihan pasca banjir.',
    imageUrl:
        'https://images.unsplash.com/photo-1547683905-f686c377644e?q=80&w=600&auto=format&fit=crop',
    category: 'Banjir',
    difficulty: 'Menengah',
    duration: 20,
    topics: ['Identifikasi Area Rawan', 'Persiapan Keluarga', 'Teknik Evakuasi', 'Pertolongan Pertama', 'Pemulihan Pasca Banjir'],
  ),
  const EducationalModule(
    id: '3',
    title: 'Keselamatan dari Kebakaran Hutan',
    description:
        'Informasi penting tentang kebakaran hutan dan dampaknya terhadap masyarakat pedesaan. Pelajari cara pencegahan kebakaran hutan, sistem alarm komunitas, koordinasi tim evakuasi, dan penanganan korban. Modul lanjutan ini juga mencakup pemahaman tentang arah angin, pembentukan jalur evakuasi, dan strategi perlindungan rumah dari api.',
    imageUrl:
        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?q=80&w=600&auto=format&fit=crop',
    category: 'Kebakaran',
    difficulty: 'Lanjutan',
    duration: 25,
    topics: ['Pencegahan Kebakaran', 'Sistem Alarm Komunitas', 'Koordinasi Tim', 'Evakuasi Aman', 'Perlindungan Rumah'],
  ),
  const EducationalModule(
    id: '4',
    title: 'Mitigasi Tanah Longsor',
    description:
        'Pelajari tentang penyebab dan gejala tanah longsor, identifikasi area yang rentan, dan cara memperkuat lereng. Modul ini mencakup konstruksi penyangga tanah, sistem drainase, dan perencanaan jalan yang aman. Termasuk juga panduan evakuasi darurat dan protokol komunikasi antar komunitas untuk mengantisipasi longsor.',
    imageUrl:
        'https://images.unsplash.com/photo-1469022563149-aa64dbd37dae?q=80&w=600&auto=format&fit=crop',
    category: 'Tanah Longsor',
    difficulty: 'Menengah',
    duration: 18,
    topics: ['Tanda-tanda Longsor', 'Identifikasi Area Rawan', 'Perkuatan Lereng', 'Sistem Drainase', 'Evakuasi Darurat'],
  ),
  const EducationalModule(
    id: '5',
    title: 'Protokol Tsunami dan Gelombang Tinggi',
    description:
        'Untuk desa-desa pesisir, pelajari tentang peringatan tsunami, sistem deteksi dini, dan jalur evakuasi vertikal. Modul ini mencakup pemahaman tentang gelombang tsunami, waktu tempuh, dan strategi penyelamatan di area pantai. Juga dijelaskan peran BMKG, sistem sirine peringatan, dan koordinasi dengan pihak berwenang.',
    imageUrl:
        'https://images.unsplash.com/photo-1505142468610-359e7d316be0?q=80&w=600&auto=format&fit=crop',
    category: 'Tsunami',
    difficulty: 'Menengah',
    duration: 22,
    topics: ['Tanda-tanda Tsunami', 'Sistem Deteksi Dini', 'Jalur Evakuasi Vertikal', 'Sirine Peringatan', 'Koordinasi Pemerintah'],
  ),
  const EducationalModule(
    id: '6',
    title: 'Kesiapsiagaan Erupsi Gunung Berapi',
    description:
        'Untuk desa yang dekat dengan gunung berapi, pelajari tentang jenis erupsi, zona bahaya, dan sistem peringatan dini. Modul ini mencakup pemahaman tentang awan panas, lahar, dan debu vulkanik. Termasuk juga perencanaan jalur evakuasi, penyiapan shelter, dan koordinasi dengan Badan Geologi untuk monitoring gunung.',
    imageUrl:
        'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?q=80&w=600&auto=format&fit=crop',
    category: 'Vulkanik',
    difficulty: 'Lanjutan',
    duration: 25,
    topics: ['Jenis Erupsi', 'Zona Bahaya', 'Sistem Peringatan', 'Evakuasi Aman', 'Monitoring Gunung'],
  ),
];