class Destination {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String location;
  final double rating;
  final double latitude;
  final double longitude;

  const Destination({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.rating,
    required this.latitude,
    required this.longitude,
  });
}

final List<Destination> mockDestinations = [
  const Destination(
    id: '1',
    name: 'Air Terjun Kedung Kayang',
    description:
        'Air terjun indah dengan pemandangan Gunung Merapi. Akses jalan cukup menantang namun sepadan dengan keindahannya.',
    imageUrl:
        'https://images.unsplash.com/photo-1543880496-7ab5d1e44f80?q=80&w=600&auto=format&fit=crop',
    location: 'Magelang, Jawa Tengah',
    rating: 4.8,
    latitude: -7.5305,
    longitude: 110.3804,
  ),
  const Destination(
    id: '2',
    name: 'Desa Wisata Nglanggeran',
    description:
        'Kawasan ekowisata gunung api purba Nglanggeran. Memiliki jalur pendakian ringan dan embung yang indah di puncak.',
    imageUrl:
        'https://images.unsplash.com/photo-1582845604675-01bdff939f50?q=80&w=600&auto=format&fit=crop',
    location: 'Gunungkidul, DIY',
    rating: 4.9,
    latitude: -7.8427,
    longitude: 110.5372,
  ),
  const Destination(
    id: '3',
    name: 'Pantai Timang',
    description:
        'Pantai ekstrem dengan atraksi kereta gantung tradisional menyeberangi laut menuju pulau karang kecil.',
    imageUrl:
        'https://images.unsplash.com/photo-1596706927546-f9ba0125c115?q=80&w=600&auto=format&fit=crop',
    location: 'Gunungkidul, DIY',
    rating: 4.7,
    latitude: -8.1186,
    longitude: 110.6433,
  ),
];
