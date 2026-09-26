import 'dart:async';
import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashOnboardingPage extends StatefulWidget {
  const SplashOnboardingPage({super.key});

  @override
  State<SplashOnboardingPage> createState() => _SplashOnboardingPageState();
}

class _SplashOnboardingPageState extends State<SplashOnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _splashTimer;

  // Total pages: Page 0 = Splash, Page 1, 2, 3 = Onboarding Slides
  final int _totalPages = 4;

  @override
  void initState() {
    super.initState();
    // Auto transition from Splash Screen (Page 0) to Onboarding (Page 1) after 2.8 seconds
    _splashTimer = Timer(const Duration(milliseconds: 2800), () {
      if (mounted && _currentPage == 0) {
        _pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _splashTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                _buildSplashScreen(),
                _buildOnboardingSlide(
                  title: 'Informasi Bencana\nDalam Genggaman',
                  subtitle:
                      'Dapatkan Informasi Real-time,\nPeringatan dini, dan jalur evakuasi\nuntuk keselamatan bersama',
                  imageAsset: 'assets/images/onboarding_1.jpg',
                  onboardingIndex: 0,
                ),
                _buildOnboardingSlide(
                  title: 'Ciptakan Keluarga\nTangguh Bencana',
                  subtitle:
                      'Jangan tunggu bahaya datang.\nBekali diri Anda dengan pengetahuan\nevakuasi dan persiapan dini demi\nkeselamatan orang-orang tercinta.',
                  imageAsset: 'assets/images/onboarding_2.jpg',
                  onboardingIndex: 1,
                ),
                _buildOnboardingSlide(
                  title: 'Warga Tangguh,\nDesa Terlindungi',
                  subtitle:
                      'Bekali diri dengan panduan evakuasi\ndan persiapan darurat untuk\nkeselamatan bersama.',
                  imageAsset: 'assets/images/onboarding_3.jpg',
                  onboardingIndex: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Tampilan Awal (Splash Screen) ---
  Widget _buildSplashScreen() {
    return Stack(
      children: [
        // Background Landscape Image
        Positioned.fill(
          child: Image.asset(
            'assets/images/splash_bg.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ),

        // Gradient overlay to keep top white & readable
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.95),
                  Colors.white.withValues(alpha: 0.85),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.45, 0.85],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),

        // Splash Content
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),

                // Logo Emblem
                Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/sigapin_logo.jpg',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.shield_outlined,
                        size: 90,
                        color: Color(0xFF1E88E5),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // App Name
                const Text(
                  'SIGAPIN',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0,
                    color: Color(0xFF1A365D),
                  ),
                ),

                const SizedBox(height: 8),

                // Subtitle 1
                const Text(
                  'Sistem Informasi Geografis',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 4),

                // Subtitle 2
                const Text(
                  'Peringatan dini & Informasi bencana',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF388E3C),
                  ),
                ),

                const Spacer(flex: 3),

                // Swipe / Tap hint
                GestureDetector(
                  onTap: () {
                    _splashTimer?.cancel();
                    _pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Geser untuk mulai',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF2E7D32),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 13,
                          color: Color(0xFF2E7D32),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 36),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- Onboarding Slide Widget ---
  Widget _buildOnboardingSlide({
    required String title,
    required String subtitle,
    required String imageAsset,
    required int onboardingIndex, // 0, 1, 2
  }) {
    final bool isLastPage = onboardingIndex == 2;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        children: [
          const SizedBox(height: 24),

          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
              height: 1.25,
            ),
          ),

          const SizedBox(height: 16),

          // Subtitle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
                color: Colors.grey[700],
                height: 1.4,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Center Illustration
          Expanded(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxHeight: 330),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    imageAsset,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 260,
                      height: 260,
                      color: Colors.grey[100],
                      child: const Icon(Icons.image, size: 80, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Page Indicator (3 dots)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              final bool isActive = index == onboardingIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: isActive ? 18 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFF4DAA1E)
                      : const Color(0xFFC8E6C9),
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),

          const SizedBox(height: 32),

          // Bottom Navigation (LEWATI & BERIKUTNYA)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // LEWATI Button
              TextButton(
                onPressed: _navigateToLogin,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                ),
                child: const Text(
                  'LEWATI',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                    color: Colors.black87,
                  ),
                ),
              ),

              // BERIKUTNYA / MULAI Button
              TextButton(
                onPressed: _goToNextPage,
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF4DAA1E),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                ),
                child: Text(
                  isLastPage ? 'BERIKUTNYA' : 'BERIKUTNYA',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                    color: Color(0xFF4DAA1E),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
