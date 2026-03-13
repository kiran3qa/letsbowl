import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const LetsBowlApp());
}

class LetsBowlApp extends StatelessWidget {
  const LetsBowlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LetsBowl',
      theme: LetsBowlTheme.theme,
      home: const LetsBowlHomeScreen(),
    );
  }
}

class LetsBowlTheme {
  static const Color black = Color(0xFF0E0F12);
  static const Color surface = Color(0xFF171A20);
  static const Color softBlack = Color(0xFF20242B);
  static const Color white = Color(0xFFF8F7F3);
  static const Color pureWhite = Colors.white;
  static const Color red = Color(0xFFD72638);
  static const Color richRed = Color(0xFFA91524);
  static const Color gold = Color(0xFFE0B84F);
  static const Color muted = Color(0xFFD6D0C7);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: black,
      colorScheme: const ColorScheme.dark(
        primary: red,
        secondary: gold,
        surface: surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}

class LetsBowlLinks {
  static final Uri callPrimary = Uri.parse('tel:+918508700000');
  static final Uri whatsapp = Uri.parse('https://wa.me/918508700000');
  static final Uri bulkBooking = Uri.parse(
    'https://wa.me/918508700000?text=Hi%20LetsBowl%2C%20I%20want%20to%20enquire%20about%20bulk%20booking.',
  );
  static final Uri reserveSlot = Uri.parse(
    'https://wa.me/918508700000?text=Hi%20LetsBowl%2C%20I%20want%20to%20reserve%20a%20slot.',
  );
  static final Uri email = Uri.parse('mailto:letsbowl.97@gmail.com');
  static final Uri maps = Uri.parse(
    'https://maps.google.com/?q=No%201/812,%20Pillaiyar%20Koil%20Street,%20MCN%20Nagar%20Extension,%20Thoraipakkam,%20Chennai%20-%20600097',
  );
  static final Uri instagram = Uri.parse('https://www.instagram.com/');
  static final Uri facebook = Uri.parse('https://www.facebook.com/');
  static final Uri youtube = Uri.parse('https://www.youtube.com/');
}

class ActivityItem {
  final String title;
  final IconData icon;
  final String tag;

  const ActivityItem(this.title, this.icon, this.tag);
}

class OfferItem {
  final String label;
  final String title;
  final String subtitle;

  const OfferItem(this.label, this.title, this.subtitle);
}

class ReviewItem {
  final String initials;
  final String name;
  final String meta;
  final String review;

  const ReviewItem(this.initials, this.name, this.meta, this.review);
}

class GalleryItem {
  final String title;
  final String subtitle;
  final String image;

  const GalleryItem(this.title, this.subtitle, this.image);
}

class LetsBowlHomeScreen extends StatefulWidget {
  const LetsBowlHomeScreen({super.key});

  @override
  State<LetsBowlHomeScreen> createState() => _LetsBowlHomeScreenState();
}

class _LetsBowlHomeScreenState extends State<LetsBowlHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final PageController _galleryController = PageController(viewportFraction: .88);
  final PageController _gamesController = PageController(viewportFraction: .72);
  final PageController _reviewController = PageController(viewportFraction: .90);

  Timer? _galleryTimer;
  Timer? _gamesTimer;
  Timer? _reviewTimer;

  int _galleryIndex = 0;
  int _gamesIndex = 0;
  int _reviewIndex = 0;

  final GlobalKey _offersKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _gamesKey = GlobalKey();
  final GlobalKey _galleryKey = GlobalKey();
  final GlobalKey _reviewsKey = GlobalKey();
  final GlobalKey _footerKey = GlobalKey();

  static const String heroVideoUrl = 'https://gobus.space/bowling.mp4';

  static const List<ActivityItem> activities = [
    ActivityItem('Bowling', Icons.sports_handball_rounded, 'Signature lanes'),
    ActivityItem('Snooker', Icons.sports_bar_rounded, 'Cue & chill'),
    ActivityItem('Arcade', Icons.videogame_asset_rounded, 'Level up nights'),
    ActivityItem('Machine Cricket', Icons.sports_cricket_rounded, 'Fast challenge'),
    ActivityItem('Badminton', Icons.sports_tennis_rounded, 'Energetic rallies'),
    ActivityItem('PickleBall', Icons.sports_baseball_rounded, 'Trendy courts'),
    ActivityItem('Table Tennis', Icons.table_bar_rounded, 'Quick matches'),
    ActivityItem('Party Hall', Icons.celebration_rounded, 'Events & birthdays'),
    ActivityItem('Chill-Pill Games', Icons.extension_rounded, 'Casual fun'),
    ActivityItem('Cafe', Icons.local_cafe_rounded, 'Food & drinks'),
  ];

  static const List<OfferItem> offers = [
    OfferItem('Limited Time', '50% OFF', 'Weekday bowling before 4 PM'),
    OfferItem('Weekend Special', 'Family Pack', '4 games + snacks for ₹999'),
    OfferItem('Daily Deal', 'Happy Hours', 'Buy 2 Get 1 Free on arcade tokens'),
    OfferItem('All Week', 'Student Deal', '30% off with valid student ID'),
    OfferItem('Book Ahead', 'Birthday Bash', 'Free lane + cake for birthday groups'),
    OfferItem('Groups 10+', 'Corporate', 'Team packages from ₹5999'),
  ];

  static const List<ReviewItem> reviews = [
    ReviewItem('AK', 'Aravind Kalyan', 'Local Guide • a month ago', 'Had a very great time at Let\'s Bowl, Thoraipakkam. Bowling alley, party space, VR arena and cafe under one roof.'),
    ReviewItem('MA', 'Mohammed Affrudin', 'Local Guide • 2 months ago', 'Awesome time at the bowling cafe. The lanes were smooth, well-maintained, and some of the best I\'ve played on.'),
    ReviewItem('RR', 'Rahul R', 'Local Guide • recently', 'A good place to try something different from regular indoor games. Bowling was fun and beginner friendly.'),
    ReviewItem('JM', 'James M', 'recently', 'Very good place for team fun activities. The VR roller coaster and zombie game were very realistic and thrilling.'),
    ReviewItem('AS', 'ameen shamshir', 'Local Guide • recently', 'Fun-filled experience with a great atmosphere. Perfect for group games and outings. Helpful staff too.'),
  ];

  static const List<GalleryItem> galleryItems = [
    GalleryItem('Bowling Vibes', 'Dummy venue image', 'https://images.unsplash.com/photo-1511884642898-4c92249e20b6?auto=format&fit=crop&w=1200&q=80'),
    GalleryItem('Arcade Energy', 'Dummy fun zone image', 'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&w=1200&q=80'),
    GalleryItem('Restaurant Mood', 'Dummy dining image', 'https://images.unsplash.com/photo-1552566626-52f8b828add9?auto=format&fit=crop&w=1200&q=80'),
    GalleryItem('Team Hangout', 'Dummy group image', 'https://images.unsplash.com/photo-1529156069898-49953e39b3ac?auto=format&fit=crop&w=1200&q=80'),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlides();
  }

  void _startAutoSlides() {
    _galleryTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_galleryController.hasClients) return;
      _galleryIndex = (_galleryIndex + 1) % galleryItems.length;
      _galleryController.animateToPage(
        _galleryIndex,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeInOut,
      );
    });

    _gamesTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_gamesController.hasClients) return;
      _gamesIndex = (_gamesIndex + 1) % activities.length;
      _gamesController.animateToPage(
        _gamesIndex,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeInOut,
      );
    });

    _reviewTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_reviewController.hasClients) return;
      _reviewIndex = (_reviewIndex + 1) % reviews.length;
      _reviewController.animateToPage(
        _reviewIndex,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _galleryController.dispose();
    _gamesController.dispose();
    _reviewController.dispose();
    _galleryTimer?.cancel();
    _gamesTimer?.cancel();
    _reviewTimer?.cancel();
    super.dispose();
  }

  Future<void> _open(Uri uri) async {
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open ${uri.toString()}')),
      );
    }
  }

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _AppDrawer(
        onOffersTap: () => _scrollTo(_offersKey),
        onAboutTap: () => _scrollTo(_aboutKey),
        onGamesTap: () => _scrollTo(_gamesKey),
        onGalleryTap: () => _scrollTo(_galleryKey),
        onReviewsTap: () => _scrollTo(_reviewsKey),
        onQuickLinksTap: () => _scrollTo(_footerKey),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            toolbarHeight: 74,
            backgroundColor: LetsBowlTheme.black.withOpacity(.84),
            leading: Builder(
              builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu_rounded, color: LetsBowlTheme.gold),
              ),
            ),
            title: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'LetsBowl',
                  style: TextStyle(
                    color: LetsBowlTheme.pureWhite,
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Strike. Sip. Celebrate.',
                  style: TextStyle(
                    color: LetsBowlTheme.gold,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => _open(LetsBowlLinks.callPrimary),
                icon: const Icon(Icons.call_rounded, color: LetsBowlTheme.red),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeroSection(
                  videoUrl: heroVideoUrl,
                  onCallTap: () => _open(LetsBowlLinks.callPrimary),
                  onWhatsAppTap: () => _open(LetsBowlLinks.whatsapp),
                  onBookTap: () => _open(LetsBowlLinks.reserveSlot),
                  onExploreTap: () => _scrollTo(_gamesKey),
                  onBulkTap: () => _open(LetsBowlLinks.bulkBooking),
                ),
                const SizedBox(height: 28),
                const _SectionHeader(
                  eyebrow: 'What We Offer',
                  title: '10 ways to have fun under one roof',
                  subtitle: 'Bowling, snooker, arcade, machine cricket, badminton, pickleball, table tennis, party hall, chill games and cafe experiences — all designed in a fresh premium layout.',
                ),
                const SizedBox(height: 16),
                Container(key: _gamesKey, child: _GamesSlider(controller: _gamesController, items: activities)),
                const SizedBox(height: 18),
                const _RunningStrip(),
                const SizedBox(height: 28),
                Container(
                  key: _offersKey,
                  child: const _SectionHeader(
                    eyebrow: 'Live Offers',
                    title: 'Grab these deals before they\'re gone',
                    subtitle: 'Professional card design rebuilt from scratch using only the offer content.',
                  ),
                ),
                const SizedBox(height: 16),
                _OffersSection(items: offers, onClaimTap: () => _open(LetsBowlLinks.whatsapp)),
                const SizedBox(height: 28),
                Container(
                  key: _aboutKey,
                  child: const _AboutBlock(),
                ),
                const SizedBox(height: 28),
                Container(
                  key: _galleryKey,
                  child: _GallerySection(controller: _galleryController, items: galleryItems),
                ),
                const SizedBox(height: 28),
                Container(
                  key: _reviewsKey,
                  child: const _SectionHeader(
                    eyebrow: 'What People Say',
                    title: '4.7 on Google Maps',
                    subtitle: 'A premium review carousel designed independently with the review content carried over.',
                  ),
                ),
                const SizedBox(height: 16),
                _ReviewCarousel(controller: _reviewController, items: reviews),
                const SizedBox(height: 28),
                _CtaBanner(onTap: () => _open(LetsBowlLinks.reserveSlot)),
                const SizedBox(height: 28),
                Container(
                  key: _footerKey,
                  child: _FooterSection(
                    onCallTap: () => _open(LetsBowlLinks.callPrimary),
                    onWhatsAppTap: () => _open(LetsBowlLinks.whatsapp),
                    onEmailTap: () => _open(LetsBowlLinks.email),
                    onMapTap: () => _open(LetsBowlLinks.maps),
                    onInstagramTap: () => _open(LetsBowlLinks.instagram),
                    onFacebookTap: () => _open(LetsBowlLinks.facebook),
                    onYoutubeTap: () => _open(LetsBowlLinks.youtube),
                    onBulkTap: () => _open(LetsBowlLinks.bulkBooking),
                  ),
                ),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: 'wa',
            backgroundColor: LetsBowlTheme.gold,
            onPressed: () => _open(LetsBowlLinks.whatsapp),
            child: const Icon(Icons.chat_rounded, color: LetsBowlTheme.black),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'call',
            backgroundColor: LetsBowlTheme.red,
            onPressed: () => _open(LetsBowlLinks.callPrimary),
            child: const Icon(Icons.call_rounded, color: LetsBowlTheme.pureWhite),
          ),
        ],
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer({
    required this.onOffersTap,
    required this.onAboutTap,
    required this.onGamesTap,
    required this.onGalleryTap,
    required this.onReviewsTap,
    required this.onQuickLinksTap,
  });

  final VoidCallback onOffersTap;
  final VoidCallback onAboutTap;
  final VoidCallback onGamesTap;
  final VoidCallback onGalleryTap;
  final VoidCallback onReviewsTap;
  final VoidCallback onQuickLinksTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: LetsBowlTheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'LetsBowl',
                style: TextStyle(
                  color: LetsBowlTheme.pureWhite,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Chennai\'s Strike Zone',
                style: TextStyle(color: LetsBowlTheme.gold, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 24),
              _DrawerTile(icon: Icons.local_offer_rounded, text: 'Offers', onTap: onOffersTap),
              _DrawerTile(icon: Icons.sports_esports_rounded, text: 'Games', onTap: onGamesTap),
              _DrawerTile(icon: Icons.info_outline_rounded, text: 'About', onTap: onAboutTap),
              _DrawerTile(icon: Icons.photo_library_rounded, text: 'Gallery', onTap: onGalleryTap),
              _DrawerTile(icon: Icons.star_rounded, text: 'Reviews', onTap: onReviewsTap),
              _DrawerTile(icon: Icons.link_rounded, text: 'Quick Links', onTap: onQuickLinksTap),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({required this.icon, required this.text, required this.onTap});

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: LetsBowlTheme.softBlack,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(.08)),
      ),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          onTap();
        },
        leading: Icon(icon, color: LetsBowlTheme.gold),
        title: Text(text, style: const TextStyle(color: LetsBowlTheme.pureWhite, fontWeight: FontWeight.w800)),
        trailing: const Icon(Icons.chevron_right_rounded, color: LetsBowlTheme.red),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({
    required this.videoUrl,
    required this.onCallTap,
    required this.onWhatsAppTap,
    required this.onBookTap,
    required this.onExploreTap,
    required this.onBulkTap,
  });

  final String videoUrl;
  final VoidCallback onCallTap;
  final VoidCallback onWhatsAppTap;
  final VoidCallback onBookTap;
  final VoidCallback onExploreTap;
  final VoidCallback onBulkTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 690,
      margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: LetsBowlTheme.black,
        boxShadow: [
          BoxShadow(
            color: LetsBowlTheme.red.withOpacity(.10),
            blurRadius: 24,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _HeroVideoBackground(videoUrl),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(.18),
                    Colors.black.withOpacity(.38),
                    LetsBowlTheme.black.withOpacity(.92),
                  ],
                ),
              ),
            ),
            Positioned(
              left: -60,
              top: -40,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: LetsBowlTheme.gold.withOpacity(.12),
                ),
              ),
            ),
            Positioned(
              right: -50,
              bottom: 120,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: LetsBowlTheme.red.withOpacity(.10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _GlassChip(label: 'Open Now!', icon: Icons.circle, iconColor: Colors.greenAccent.shade400),
                      const SizedBox(width: 8),
                      _GlassChip(label: 'Until 11:00 PM', icon: Icons.access_time_rounded),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _TopActionCard(
                          title: 'Call Now',
                          subtitle: '+91 85087 00000',
                          icon: Icons.call_rounded,
                          onTap: onCallTap,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _TopActionCard(
                          title: 'WhatsApp',
                          subtitle: 'Fast booking help',
                          icon: Icons.chat_rounded,
                          onTap: onWhatsAppTap,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Text(
                    'CHENNAI\'S\nSTRIKE ZONE',
                    style: TextStyle(
                      color: LetsBowlTheme.pureWhite,
                      fontSize: 40,
                      height: 1.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Premium bowling, arcade, snooker & more. Your ultimate entertainment destination in the heart of Chennai.',
                    style: TextStyle(
                      color: LetsBowlTheme.white,
                      fontSize: 15.5,
                      height: 1.55,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: _PrimaryButton(
                          text: 'Reserve Your Slot',
                          background: LetsBowlTheme.red,
                          foreground: LetsBowlTheme.pureWhite,
                          onTap: onBookTap,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _PrimaryButton(
                          text: 'Explore Games',
                          background: LetsBowlTheme.gold,
                          foreground: LetsBowlTheme.black,
                          onTap: onExploreTap,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.10),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withOpacity(.10)),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Bulk Booking', style: TextStyle(color: LetsBowlTheme.gold, fontWeight: FontWeight.w800)),
                              SizedBox(height: 4),
                              Text('Party, groups & events', style: TextStyle(color: LetsBowlTheme.white)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 84,
                        child: _PrimaryButton(
                          text: 'Go',
                          background: LetsBowlTheme.pureWhite,
                          foreground: LetsBowlTheme.black,
                          onTap: onBulkTap,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const _HeroStats(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroVideoBackground extends StatefulWidget {
  const _HeroVideoBackground(this.videoUrl);

  final String videoUrl;

  @override
  State<_HeroVideoBackground> createState() => _HeroVideoBackgroundState();
}

class _HeroVideoBackgroundState extends State<_HeroVideoBackground> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) {
        if (!mounted) return;
        _controller?.play();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2B1518), Color(0xFF13161B), Color(0xFF4A3A12)],
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: LetsBowlTheme.gold),
        ),
      );
    }

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        width: controller.value.size.width,
        height: controller.value.size.height,
        child: VideoPlayer(controller),
      ),
    );
  }
}

class _GlassChip extends StatelessWidget {
  const _GlassChip({required this.label, required this.icon, this.iconColor});

  final String label;
  final IconData icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: iconColor ?? LetsBowlTheme.gold),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: LetsBowlTheme.pureWhite, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _TopActionCard extends StatelessWidget {
  const _TopActionCard({required this.title, required this.subtitle, required this.icon, required this.onTap});

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.10),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(.10)),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: LetsBowlTheme.red.withOpacity(.92),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: LetsBowlTheme.pureWhite),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: LetsBowlTheme.pureWhite, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(color: LetsBowlTheme.muted, fontSize: 12.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroStats extends StatelessWidget {
  const _HeroStats();

  @override
  Widget build(BuildContext context) {
    Widget buildStat(String value, String label) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.07),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withOpacity(.08)),
          ),
          child: Column(
            children: [
              Text(value, style: const TextStyle(color: LetsBowlTheme.gold, fontSize: 20, fontWeight: FontWeight.w900)),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(color: LetsBowlTheme.white, fontSize: 12.5)),
            ],
          ),
        ),
      );
    }

    return Row(
      children: [
        buildStat('10', 'Experiences'),
        const SizedBox(width: 10),
        buildStat('4.7', 'Google Rating'),
        const SizedBox(width: 10),
        buildStat('11 PM', 'Open Daily'),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.eyebrow, required this.title, required this.subtitle});

  final String eyebrow;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eyebrow.toUpperCase(),
            style: const TextStyle(color: LetsBowlTheme.gold, fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1.1),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(color: LetsBowlTheme.pureWhite, fontSize: 28, height: 1.1, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(subtitle, style: const TextStyle(color: LetsBowlTheme.muted, fontSize: 14.5, height: 1.5)),
        ],
      ),
    );
  }
}

class _GamesSlider extends StatelessWidget {
  const _GamesSlider({required this.controller, required this.items});

  final PageController controller;
  final List<ActivityItem> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 235,
      child: PageView.builder(
        controller: controller,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF251316), Color(0xFF171A20), Color(0xFF3A2E10)],
                ),
                border: Border.all(color: Colors.white.withOpacity(.08)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: LetsBowlTheme.pureWhite,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(item.icon, color: LetsBowlTheme.red, size: 30),
                  ),
                  const Spacer(),
                  Text(item.tag, style: const TextStyle(color: LetsBowlTheme.gold, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text(item.title, style: const TextStyle(color: LetsBowlTheme.pureWhite, fontSize: 26, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: LetsBowlTheme.red,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Center(
                            child: Text('Book Now', style: TextStyle(color: LetsBowlTheme.pureWhite, fontWeight: FontWeight.w800)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: LetsBowlTheme.gold,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Icon(Icons.arrow_forward_rounded, color: LetsBowlTheme.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RunningStrip extends StatelessWidget {
  const _RunningStrip();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: LetsBowlTheme.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        child: Text(
          'EAT • PLAY • BOWL • REPEAT • EAT • PLAY • BOWL • REPEAT • EAT • PLAY • BOWL • REPEAT',
          style: TextStyle(color: LetsBowlTheme.pureWhite, fontWeight: FontWeight.w900, letterSpacing: .4),
        ),
      ),
    );
  }
}

class _OffersSection extends StatelessWidget {
  const _OffersSection({required this.items, required this.onClaimTap});

  final List<OfferItem> items;
  final VoidCallback onClaimTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            width: 270,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: LetsBowlTheme.white,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: LetsBowlTheme.gold.withOpacity(.18),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(item.label, style: const TextStyle(color: LetsBowlTheme.richRed, fontWeight: FontWeight.w800, fontSize: 12)),
                ),
                const Spacer(),
                Text(item.title, style: const TextStyle(color: LetsBowlTheme.black, fontSize: 28, fontWeight: FontWeight.w900)),
                const SizedBox(height: 8),
                Text(item.subtitle, style: const TextStyle(color: Colors.black87, height: 1.45, fontWeight: FontWeight.w500)),
                const SizedBox(height: 16),
                _PrimaryButton(text: 'Claim Offer', background: LetsBowlTheme.black, foreground: LetsBowlTheme.gold, onTap: onClaimTap),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AboutBlock extends StatelessWidget {
  const _AboutBlock();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: LetsBowlTheme.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: LetsBowlTheme.gold.withOpacity(.15)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About Us', style: TextStyle(color: LetsBowlTheme.gold, fontWeight: FontWeight.w800, fontSize: 13)),
          SizedBox(height: 12),
          Text(
            'LetsBowl is Chennai\'s premier entertainment destination, bringing together world-class bowling lanes, an exciting arcade zone, professional snooker tables, and a vibrant cafe—all under one roof. Whether you\'re planning a family outing, a corporate event, or just a fun day with friends, we\'ve got you covered.',
            style: TextStyle(color: LetsBowlTheme.pureWhite, fontSize: 16, height: 1.6, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _TagChip('BOWLING'),
              _TagChip('ARCADE'),
              _TagChip('SNOOKER'),
              _TagChip('CAFE'),
              _TagChip('PARTY'),
            ],
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.06),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: const TextStyle(color: LetsBowlTheme.red, fontWeight: FontWeight.w900, letterSpacing: .3)),
    );
  }
}

class _GallerySection extends StatelessWidget {
  const _GallerySection({required this.controller, required this.items});

  final PageController controller;
  final List<GalleryItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(
          eyebrow: 'Gallery',
          title: 'Sliding dummy visuals for the app',
          subtitle: 'These image cards are placeholders so the interface feels premium until you replace them with final venue photos.',
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: controller,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _NetworkPhoto(item.image),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black.withOpacity(.82)],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Text(item.title, style: const TextStyle(color: LetsBowlTheme.pureWhite, fontWeight: FontWeight.w900, fontSize: 26)),
                            const SizedBox(height: 6),
                            Text(item.subtitle, style: const TextStyle(color: LetsBowlTheme.white, fontSize: 14)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ReviewCarousel extends StatelessWidget {
  const _ReviewCarousel({required this.controller, required this.items});

  final PageController controller;
  final List<ReviewItem> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: PageView.builder(
        controller: controller,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: LetsBowlTheme.surface,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.white.withOpacity(.08)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(color: LetsBowlTheme.red, shape: BoxShape.circle),
                        child: Center(
                          child: Text(item.initials, style: const TextStyle(color: LetsBowlTheme.pureWhite, fontWeight: FontWeight.w800)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name, style: const TextStyle(color: LetsBowlTheme.pureWhite, fontWeight: FontWeight.w800)),
                            const SizedBox(height: 2),
                            Text(item.meta, style: const TextStyle(color: LetsBowlTheme.muted, fontSize: 12.5)),
                          ],
                        ),
                      ),
                      const Icon(Icons.star_rounded, color: LetsBowlTheme.gold),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Text(
                      item.review,
                      style: const TextStyle(color: LetsBowlTheme.white, height: 1.55, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Google', style: TextStyle(color: LetsBowlTheme.gold, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CtaBanner extends StatelessWidget {
  const _CtaBanner({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [LetsBowlTheme.red, LetsBowlTheme.black, Color(0xFF5A4816)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('THE PLACE WHERE', style: TextStyle(color: LetsBowlTheme.gold, fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          const Text('MEMORIES ARE MADE', style: TextStyle(color: LetsBowlTheme.pureWhite, fontSize: 32, height: 1.05, fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          const Text(
            'From birthday parties to corporate team-building, from casual hangouts to competitive tournaments—LetsBowl is where Chennai comes to play.',
            style: TextStyle(color: LetsBowlTheme.white, height: 1.55, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 18),
          _PrimaryButton(text: 'Reserve Your Slot', background: LetsBowlTheme.pureWhite, foreground: LetsBowlTheme.black, onTap: onTap),
        ],
      ),
    );
  }
}

class _FooterSection extends StatelessWidget {
  const _FooterSection({
    required this.onCallTap,
    required this.onWhatsAppTap,
    required this.onEmailTap,
    required this.onMapTap,
    required this.onInstagramTap,
    required this.onFacebookTap,
    required this.onYoutubeTap,
    required this.onBulkTap,
  });

  final VoidCallback onCallTap;
  final VoidCallback onWhatsAppTap;
  final VoidCallback onEmailTap;
  final VoidCallback onMapTap;
  final VoidCallback onInstagramTap;
  final VoidCallback onFacebookTap;
  final VoidCallback onYoutubeTap;
  final VoidCallback onBulkTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: LetsBowlTheme.surface,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('LetsBowl', style: TextStyle(color: LetsBowlTheme.pureWhite, fontSize: 26, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          const Text('Chennai\'s Strike Zone', style: TextStyle(color: LetsBowlTheme.gold, fontWeight: FontWeight.w700)),
          const SizedBox(height: 18),
          _FooterRow(icon: Icons.call_rounded, text: '+91 85087 00000  •  +91 9040145678  •  044-24560000', onTap: onCallTap),
          const SizedBox(height: 10),
          _FooterRow(icon: Icons.chat_rounded, text: 'WhatsApp Us', onTap: onWhatsAppTap),
          const SizedBox(height: 10),
          _FooterRow(icon: Icons.email_rounded, text: 'letsbowl.97@gmail.com', onTap: onEmailTap),
          const SizedBox(height: 10),
          _FooterRow(icon: Icons.location_on_rounded, text: 'No 1/812, Pillaiyar Koil Street, MCN Nagar Extension, Thoraipakkam, Chennai - 600097', onTap: onMapTap),
          const SizedBox(height: 12),
          const Text('Open Daily until 11:00 PM', style: TextStyle(color: LetsBowlTheme.muted, fontWeight: FontWeight.w600)),
          const SizedBox(height: 18),
          Row(
            children: [
              _SocialButton(icon: Icons.camera_alt_rounded, onTap: onInstagramTap),
              const SizedBox(width: 8),
              _SocialButton(icon: Icons.play_arrow_rounded, onTap: onYoutubeTap),
              const SizedBox(width: 8),
              _SocialButton(icon: Icons.facebook_rounded, onTap: onFacebookTap),
            ],
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _MiniActionChip(label: 'Bulk Booking', onTap: onBulkTap),
              _MiniActionChip(label: 'Party Hall', onTap: onBulkTap),
              _MiniActionChip(label: 'Tournaments', onTap: onBulkTap),
            ],
          ),
          const SizedBox(height: 18),
          Divider(color: Colors.white.withOpacity(.08)),
          const SizedBox(height: 10),
          const Text('© 2026 LetsBowl. All rights reserved.', style: TextStyle(color: LetsBowlTheme.muted, fontSize: 12.5)),
        ],
      ),
    );
  }
}

class _FooterRow extends StatelessWidget {
  const _FooterRow({required this.icon, required this.text, required this.onTap});

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: LetsBowlTheme.gold, size: 20),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(color: LetsBowlTheme.white, height: 1.5, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(.06),
        ),
        child: Icon(icon, color: LetsBowlTheme.gold),
      ),
    );
  }
}

class _MiniActionChip extends StatelessWidget {
  const _MiniActionChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: LetsBowlTheme.gold,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(label, style: const TextStyle(color: LetsBowlTheme.black, fontWeight: FontWeight.w800)),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.text, required this.background, required this.foreground, required this.onTap});

  final String text;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          child: Center(
            child: Text(text, style: TextStyle(color: foreground, fontWeight: FontWeight.w800, fontSize: 14.5)),
          ),
        ),
      ),
    );
  }
}

class _NetworkPhoto extends StatelessWidget {
  const _NetworkPhoto(this.url);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF2B1518), Color(0xFF0E0E0E), Color(0xFF443410)],
            ),
          ),
          child: const Center(
            child: Icon(Icons.image_not_supported_rounded, color: LetsBowlTheme.gold, size: 42),
          ),
        );
      },
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          color: LetsBowlTheme.softBlack,
          child: const Center(
            child: CircularProgressIndicator(color: LetsBowlTheme.gold),
          ),
        );
      },
    );
  }
}
