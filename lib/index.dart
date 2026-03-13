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
  static const Color black = Color(0xFF090A0D);
  static const Color panel = Color(0xFF111317);
  static const Color panel2 = Color(0xFF171B22);
  static const Color panel3 = Color(0xFF1B2029);
  static const Color white = Color(0xFFF8F6F1);
  static const Color muted = Color(0xFFD9D1C4);
  static const Color red = Color(0xFFC81D25);
  static const Color redDeep = Color(0xFF8F131B);
  static const Color gold = Color(0xFFE2B95A);
  static const Color green = Color(0xFF1FAA59);
  static const Color stroke = Color(0x24FFFFFF);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: black,
      colorScheme: const ColorScheme.dark(
        primary: red,
        secondary: gold,
        surface: panel,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}

class LetsBowlAssets {
  static const String logo = 'https://gobus.space/logo.png';
  static const String heroVideo = 'https://gobus.space/bowling.mp4';

  static const String whatsappIcon =
      'https://img.icons8.com/color/96/whatsapp--v1.png';
  static const String instagramIcon =
      'https://img.icons8.com/color/96/instagram-new--v1.png';
  static const String youtubeIcon =
      'https://img.icons8.com/color/96/youtube-play.png';
  static const String facebookIcon =
      'https://img.icons8.com/color/96/facebook-new.png';
}

class LetsBowlLinks {
  static final Uri callPrimary = Uri.parse('tel:+918508700000');
  static final Uri whatsapp = Uri.parse('https://wa.me/918508700000');
  static final Uri reserveSlot = Uri.parse(
    'https://wa.me/918508700000?text=Hi%20LetsBowl%2C%20I%20want%20to%20reserve%20a%20slot.',
  );
  static final Uri bulkBooking = Uri.parse(
    'https://wa.me/918508700000?text=Hi%20LetsBowl%2C%20I%20want%20to%20enquire%20about%20bulk%20booking.',
  );
  static final Uri email = Uri.parse('mailto:letsbowl.97@gmail.com');
  static final Uri maps = Uri.parse(
    'https://maps.google.com/?q=No%201/812,%20Pillaiyar%20Koil%20Street,%20MCN%20Nagar%20Extension,%20Thoraipakkam,%20Chennai%20-%20600097',
  );
  static final Uri instagram = Uri.parse('https://www.instagram.com/');
  static final Uri youtube = Uri.parse('https://www.youtube.com/');
  static final Uri facebook = Uri.parse('https://www.facebook.com/');
}

class ActivityItem {
  final String title;
  final String subtitle;
  final IconData icon;

  const ActivityItem(this.title, this.subtitle, this.icon);
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
  final PageController _gamesController = PageController(viewportFraction: .86);
  final PageController _galleryController =
      PageController(viewportFraction: .90);
  final PageController _reviewController =
      PageController(viewportFraction: .92);

  Timer? _gamesTimer;
  Timer? _galleryTimer;
  Timer? _reviewTimer;

  int _gamesIndex = 0;
  int _galleryIndex = 0;
  int _reviewIndex = 0;

  final GlobalKey _gamesKey = GlobalKey();
  final GlobalKey _offersKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _galleryKey = GlobalKey();
  final GlobalKey _reviewsKey = GlobalKey();
  final GlobalKey _footerKey = GlobalKey();

  static const List<ActivityItem> activities = [
    ActivityItem(
      'Bowling',
      'Signature lanes with a premium atmosphere for casual play and serious fun.',
      Icons.sports_handball_rounded,
    ),
    ActivityItem(
      'Snooker',
      'Smooth tables and a refined setting for focused game time.',
      Icons.sports_bar_rounded,
    ),
    ActivityItem(
      'Arcade',
      'Fast-paced games that keep the energy high for every age group.',
      Icons.videogame_asset_rounded,
    ),
    ActivityItem(
      'Machine Cricket',
      'High-energy batting action with instant fun for groups.',
      Icons.sports_cricket_rounded,
    ),
    ActivityItem(
      'Badminton',
      'Active indoor fun for friends, families and teams.',
      Icons.sports_tennis_rounded,
    ),
    ActivityItem(
      'PickleBall',
      'Trendy social gameplay in a lively indoor environment.',
      Icons.sports_baseball_rounded,
    ),
    ActivityItem(
      'Table Tennis',
      'Quick rallies and competitive fun in a cleaner premium setup.',
      Icons.table_bar_rounded,
    ),
    ActivityItem(
      'Party Hall',
      'Birthdays, celebrations and private events with a stronger venue feel.',
      Icons.celebration_rounded,
    ),
    ActivityItem(
      'Chill Games',
      'Casual entertainment zones built for relaxed hangouts.',
      Icons.extension_rounded,
    ),
    ActivityItem(
      'Cafe',
      'Food, drinks and a vibrant dine-and-play atmosphere.',
      Icons.local_cafe_rounded,
    ),
  ];

  static const List<OfferItem> offers = [
    OfferItem('Weekday Deal', '50% OFF', 'Bowling before 4 PM on weekdays'),
    OfferItem('Family Combo', '₹999 Pack', '4 games plus snacks for groups'),
    OfferItem('Arcade Deal', 'Buy 2 Get 1', 'More playtime during happy hours'),
    OfferItem(
      'Student Offer',
      '30% OFF',
      'Special pricing with valid student ID',
    ),
    OfferItem(
      'Birthday Bash',
      'Free Lane',
      'Free lane and cake for birthday groups',
    ),
    OfferItem(
      'Corporate Pack',
      'From ₹5999',
      'Team events and office outings made easy',
    ),
  ];

  static const List<ReviewItem> reviews = [
    ReviewItem(
      'AK',
      'Aravind Kalyan',
      'Local Guide • a month ago',
      'Had a great time at Let\'s Bowl, Thoraipakkam. Bowling alley, party space, VR arena and cafe under one roof.',
    ),
    ReviewItem(
      'MA',
      'Mohammed Affrudin',
      'Local Guide • 2 months ago',
      'Awesome time at the bowling cafe. The lanes were smooth, well-maintained, and some of the best I\'ve played on.',
    ),
    ReviewItem(
      'RR',
      'Rahul R',
      'Local Guide • recently',
      'A good place to try something different from regular indoor games. Bowling was fun and beginner friendly.',
    ),
    ReviewItem(
      'JM',
      'James M',
      'recently',
      'Very good place for team fun activities. The VR roller coaster and zombie game were very realistic and thrilling.',
    ),
    ReviewItem(
      'AS',
      'Ameen Shamshir',
      'Local Guide • recently',
      'Fun-filled experience with a great atmosphere. Perfect for group games and outings. Helpful staff too.',
    ),
  ];

  static const List<GalleryItem> galleryItems = [
    GalleryItem(
      'Bowling Vibes',
      'Premium play environment',
      'https://images.unsplash.com/photo-1511884642898-4c92249e20b6?auto=format&fit=crop&w=1400&q=80',
    ),
    GalleryItem(
      'Arcade Energy',
      'Fast-moving fun',
      'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&w=1400&q=80',
    ),
    GalleryItem(
      'Restaurant Mood',
      'Dining and lounge ambience',
      'https://images.unsplash.com/photo-1552566626-52f8b828add9?auto=format&fit=crop&w=1400&q=80',
    ),
    GalleryItem(
      'Team Hangout',
      'Built for groups and celebrations',
      'https://images.unsplash.com/photo-1529156069898-49953e39b3ac?auto=format&fit=crop&w=1400&q=80',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlides();
  }

  void _startAutoSlides() {
    _gamesTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_gamesController.hasClients) return;
      _gamesIndex = (_gamesIndex + 1) % activities.length;
      _gamesController.animateToPage(
        _gamesIndex,
        duration: const Duration(milliseconds: 520),
        curve: Curves.easeInOutCubic,
      );
    });

    _galleryTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_galleryController.hasClients) return;
      _galleryIndex = (_galleryIndex + 1) % galleryItems.length;
      _galleryController.animateToPage(
        _galleryIndex,
        duration: const Duration(milliseconds: 520),
        curve: Curves.easeInOutCubic,
      );
    });

    _reviewTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!_reviewController.hasClients) return;
      _reviewIndex = (_reviewIndex + 1) % reviews.length;
      _reviewController.animateToPage(
        _reviewIndex,
        duration: const Duration(milliseconds: 520),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _gamesTimer?.cancel();
    _galleryTimer?.cancel();
    _reviewTimer?.cancel();
    _scrollController.dispose();
    _gamesController.dispose();
    _galleryController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _open(Uri uri) async {
    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open ${uri.toString()}')),
      );
    }
  }

  void _scrollTo(GlobalKey key) {
    final currentContext = key.currentContext;
    if (currentContext == null) return;
    Scrollable.ensureVisible(
      currentContext,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final showRailActions = width >= 1100;

    return Scaffold(
      drawer: _AppDrawer(
        onGamesTap: () => _scrollTo(_gamesKey),
        onOffersTap: () => _scrollTo(_offersKey),
        onAboutTap: () => _scrollTo(_aboutKey),
        onGalleryTap: () => _scrollTo(_galleryKey),
        onReviewsTap: () => _scrollTo(_reviewsKey),
        onQuickLinksTap: () => _scrollTo(_footerKey),
      ),
      body: Stack(
        children: [
          const _AppBackdrop(),
          SafeArea(
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  toolbarHeight: 84,
                  backgroundColor: LetsBowlTheme.black.withOpacity(.94),
                  leading: Builder(
                    builder: (context) => IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(
                        Icons.menu_rounded,
                        color: LetsBowlTheme.gold,
                      ),
                    ),
                  ),
                  title: const _HeaderBrand(),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () => _open(LetsBowlLinks.whatsapp),
                      icon: const _NetworkIcon(
                        LetsBowlAssets.whatsappIcon,
                        size: 23,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () => _open(LetsBowlLinks.callPrimary),
                        borderRadius: BorderRadius.circular(999),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: LetsBowlTheme.green,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.call_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Call',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1400),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                            child: _HeroSection(
                              onCallTap: () => _open(LetsBowlLinks.callPrimary),
                              onWhatsAppTap: () => _open(LetsBowlLinks.whatsapp),
                              onBookTap: () => _open(LetsBowlLinks.reserveSlot),
                              onExploreTap: () => _scrollTo(_gamesKey),
                              onBulkTap: () => _open(LetsBowlLinks.bulkBooking),
                            ),
                          ),
                          const SizedBox(height: 28),
                          _SectionBlock(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const _SectionHeader(
                                  eyebrow: 'Experiences',
                                  title:
                                      'Professional presentation for every game zone',
                                  subtitle:
                                      'Cleaner typography, tighter spacing and stronger cards keep the text readable and remove the wrapped clutter from the previous layout.',
                                ),
                                const SizedBox(height: 18),
                                Container(
                                  key: _gamesKey,
                                  child: _GamesSlider(
                                    controller: _gamesController,
                                    items: activities,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: _RunningStrip(),
                          ),
                          const SizedBox(height: 28),
                          _SectionBlock(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  key: _offersKey,
                                  child: const _SectionHeader(
                                    eyebrow: 'Offers',
                                    title:
                                        'Offer cards redesigned with better balance and hierarchy',
                                    subtitle:
                                        'The text now has more breathing room, stronger contrast and a cleaner premium appearance.',
                                  ),
                                ),
                                const SizedBox(height: 18),
                                _OffersSection(
                                  items: offers,
                                  onClaimTap: () => _open(LetsBowlLinks.whatsapp),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 28),
                          _SectionBlock(
                            child: Container(
                              key: _aboutKey,
                              child: const _AboutSection(),
                            ),
                          ),
                          const SizedBox(height: 28),
                          _SectionBlock(
                            child: Container(
                              key: _galleryKey,
                              child: _GallerySection(
                                controller: _galleryController,
                                items: galleryItems,
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),
                          _SectionBlock(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  key: _reviewsKey,
                                  child: const _SectionHeader(
                                    eyebrow: 'Reviews',
                                    title:
                                        'Sharper review layout with premium readability',
                                    subtitle:
                                        'Reduced crowding, cleaner spacing and improved contrast make the testimonials feel more trustworthy to clients.',
                                  ),
                                ),
                                const SizedBox(height: 18),
                                _ReviewCarousel(
                                  controller: _reviewController,
                                  items: reviews,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 28),
                          _SectionBlock(
                            child: _CtaBanner(
                              onTap: () => _open(LetsBowlLinks.reserveSlot),
                            ),
                          ),
                          const SizedBox(height: 28),
                          _SectionBlock(
                            child: Container(
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
                          ),
                          const SizedBox(height: 34),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (showRailActions)
            Positioned(
              right: 22,
              bottom: 26,
              child: _FloatingActionRail(
                onWhatsAppTap: () => _open(LetsBowlLinks.whatsapp),
                onCallTap: () => _open(LetsBowlLinks.callPrimary),
              ),
            ),
        ],
      ),
      floatingActionButton: showRailActions
          ? null
          : _FloatingActionRail(
              onWhatsAppTap: () => _open(LetsBowlLinks.whatsapp),
              onCallTap: () => _open(LetsBowlLinks.callPrimary),
            ),
    );
  }
}

class _AppBackdrop extends StatelessWidget {
  const _AppBackdrop();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF090A0D),
            Color(0xFF0E1117),
            Color(0xFF090A0D),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -120,
            left: -90,
            child: _BackdropGlow(
              size: 280,
              color: LetsBowlTheme.red.withOpacity(.10),
            ),
          ),
          Positioned(
            top: 180,
            right: -110,
            child: _BackdropGlow(
              size: 260,
              color: LetsBowlTheme.gold.withOpacity(.08),
            ),
          ),
          Positioned(
            bottom: -120,
            left: 10,
            child: _BackdropGlow(
              size: 320,
              color: LetsBowlTheme.red.withOpacity(.09),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackdropGlow extends StatelessWidget {
  const _BackdropGlow({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}

class _HeaderBrand extends StatelessWidget {
  const _HeaderBrand();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _LogoBadge(size: 44),
        SizedBox(width: 12),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LetsBowl',
              style: TextStyle(
                color: LetsBowlTheme.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                height: 1,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'Strike. Sip. Celebrate.',
              style: TextStyle(
                color: LetsBowlTheme.gold,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SectionBlock extends StatelessWidget {
  const _SectionBlock({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: child,
    );
  }
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer({
    required this.onGamesTap,
    required this.onOffersTap,
    required this.onAboutTap,
    required this.onGalleryTap,
    required this.onReviewsTap,
    required this.onQuickLinksTap,
  });

  final VoidCallback onGamesTap;
  final VoidCallback onOffersTap;
  final VoidCallback onAboutTap;
  final VoidCallback onGalleryTap;
  final VoidCallback onReviewsTap;
  final VoidCallback onQuickLinksTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: LetsBowlTheme.panel,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  _LogoBadge(size: 54),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LetsBowl',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: LetsBowlTheme.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Premium entertainment destination',
                          style: TextStyle(
                            color: LetsBowlTheme.gold,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _DrawerTile(
                icon: Icons.sports_esports_rounded,
                text: 'Games',
                onTap: onGamesTap,
              ),
              _DrawerTile(
                icon: Icons.local_offer_rounded,
                text: 'Offers',
                onTap: onOffersTap,
              ),
              _DrawerTile(
                icon: Icons.info_outline_rounded,
                text: 'About',
                onTap: onAboutTap,
              ),
              _DrawerTile(
                icon: Icons.photo_library_outlined,
                text: 'Gallery',
                onTap: onGalleryTap,
              ),
              _DrawerTile(
                icon: Icons.star_rounded,
                text: 'Reviews',
                onTap: onReviewsTap,
              ),
              _DrawerTile(
                icon: Icons.link_rounded,
                text: 'Quick Links',
                onTap: onQuickLinksTap,
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: _DrawerActionButton(
                      icon: Icons.call_rounded,
                      label: 'Call',
                      color: LetsBowlTheme.green,
                      onTap: () {
                        Navigator.pop(context);
                        launchUrl(
                          LetsBowlLinks.callPrimary,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _DrawerActionButton(
                      label: 'WhatsApp',
                      color: LetsBowlTheme.green,
                      iconWidget: const _NetworkIcon(
                        LetsBowlAssets.whatsappIcon,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        launchUrl(
                          LetsBowlLinks.whatsapp,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: LetsBowlTheme.panel2,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: LetsBowlTheme.stroke),
      ),
      child: ListTile(
        onTap: () {
          Navigator.pop(context);
          onTap();
        },
        leading: Icon(icon, color: LetsBowlTheme.gold),
        title: Text(
          text,
          style: const TextStyle(
            color: LetsBowlTheme.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: LetsBowlTheme.red,
        ),
      ),
    );
  }
}

class _DrawerActionButton extends StatelessWidget {
  const _DrawerActionButton({
    required this.label,
    required this.color,
    required this.onTap,
    this.icon,
    this.iconWidget,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;
  final IconData? icon;
  final Widget? iconWidget;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconWidget ?? Icon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({
    required this.onCallTap,
    required this.onWhatsAppTap,
    required this.onBookTap,
    required this.onExploreTap,
    required this.onBulkTap,
  });

  final VoidCallback onCallTap;
  final VoidCallback onWhatsAppTap;
  final VoidCallback onBookTap;
  final VoidCallback onExploreTap;
  final VoidCallback onBulkTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final bool isWide = width >= 980;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        border: Border.all(color: LetsBowlTheme.stroke),
        boxShadow: [
          BoxShadow(
            color: LetsBowlTheme.red.withOpacity(.10),
            blurRadius: 36,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: Stack(
          children: [
            const Positioned.fill(
              child: _HeroVideoBackground(LetsBowlAssets.heroVideo),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(.12),
                      Colors.black.withOpacity(.42),
                      const Color(0xFF090A0D).withOpacity(.96),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -35,
              right: -30,
              child: _BackdropGlow(
                size: 180,
                color: LetsBowlTheme.gold.withOpacity(.10),
              ),
            ),
            Positioned(
              bottom: -42,
              left: -26,
              child: _BackdropGlow(
                size: 150,
                color: LetsBowlTheme.red.withOpacity(.10),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(isWide ? 32 : 22),
              child: isWide
                  ? _HeroWideLayout(
                      onCallTap: onCallTap,
                      onWhatsAppTap: onWhatsAppTap,
                      onBookTap: onBookTap,
                      onExploreTap: onExploreTap,
                      onBulkTap: onBulkTap,
                    )
                  : _HeroCompactLayout(
                      onCallTap: onCallTap,
                      onWhatsAppTap: onWhatsAppTap,
                      onBookTap: onBookTap,
                      onExploreTap: onExploreTap,
                      onBulkTap: onBulkTap,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroWideLayout extends StatelessWidget {
  const _HeroWideLayout({
    required this.onCallTap,
    required this.onWhatsAppTap,
    required this.onBookTap,
    required this.onExploreTap,
    required this.onBulkTap,
  });

  final VoidCallback onCallTap;
  final VoidCallback onWhatsAppTap;
  final VoidCallback onBookTap;
  final VoidCallback onExploreTap;
  final VoidCallback onBulkTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 11,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    _StatusChip(
                      label: 'Open Now',
                      icon: Icons.circle,
                      iconColor: Color(0xFF57FF9A),
                    ),
                    SizedBox(width: 10),
                    _StatusChip(
                      label: 'Daily till 11 PM',
                      icon: Icons.access_time_rounded,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const _HeroBrandIntro(),
                const Spacer(),
                const _HeroMainCopy(isWide: true),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: _PrimaryButton(
                        text: 'Reserve Your Slot',
                        background: LetsBowlTheme.red,
                        foreground: Colors.white,
                        onTap: onBookTap,
                      ),
                    ),
                    const SizedBox(width: 12),
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
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _PrimaryButton(
                        text: 'WhatsApp Booking',
                        background: LetsBowlTheme.green,
                        foreground: Colors.white,
                        onTap: onWhatsAppTap,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _PrimaryButton(
                        text: 'Bulk Booking',
                        background: Colors.white,
                        foreground: LetsBowlTheme.black,
                        onTap: onBulkTap,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 22),
          Expanded(
            flex: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _TopActionButton(
                        title: 'Call Now',
                        subtitle: '+91 85087 00000',
                        icon: Icons.call_rounded,
                        color: LetsBowlTheme.green,
                        onTap: onCallTap,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _TopActionButton(
                        title: 'WhatsApp',
                        subtitle: 'Quick booking support',
                        color: LetsBowlTheme.green,
                        iconWidget: const _NetworkIcon(
                          LetsBowlAssets.whatsappIcon,
                          size: 20,
                        ),
                        onTap: onWhatsAppTap,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const _HeroStatsPanel(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCompactLayout extends StatelessWidget {
  const _HeroCompactLayout({
    required this.onCallTap,
    required this.onWhatsAppTap,
    required this.onBookTap,
    required this.onExploreTap,
    required this.onBulkTap,
  });

  final VoidCallback onCallTap;
  final VoidCallback onWhatsAppTap;
  final VoidCallback onBookTap;
  final VoidCallback onExploreTap;
  final VoidCallback onBulkTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            _StatusChip(
              label: 'Open Now',
              icon: Icons.circle,
              iconColor: Color(0xFF57FF9A),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _StatusChip(
                label: 'Daily till 11 PM',
                icon: Icons.access_time_rounded,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        const _HeroBrandIntro(),
        const SizedBox(height: 24),
        const _HeroMainCopy(isWide: false),
        const SizedBox(height: 22),
        Row(
          children: [
            Expanded(
              child: _TopActionButton(
                title: 'Call Now',
                subtitle: '+91 85087 00000',
                icon: Icons.call_rounded,
                color: LetsBowlTheme.green,
                onTap: onCallTap,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _TopActionButton(
                title: 'WhatsApp',
                subtitle: 'Quick booking support',
                color: LetsBowlTheme.green,
                iconWidget: const _NetworkIcon(
                  LetsBowlAssets.whatsappIcon,
                  size: 18,
                ),
                onTap: onWhatsAppTap,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _PrimaryButton(
          text: 'Reserve Your Slot',
          background: LetsBowlTheme.red,
          foreground: Colors.white,
          onTap: onBookTap,
        ),
        const SizedBox(height: 10),
        _PrimaryButton(
          text: 'Explore Games',
          background: LetsBowlTheme.gold,
          foreground: LetsBowlTheme.black,
          onTap: onExploreTap,
        ),
        const SizedBox(height: 10),
        _PrimaryButton(
          text: 'WhatsApp Booking',
          background: LetsBowlTheme.green,
          foreground: Colors.white,
          onTap: onWhatsAppTap,
        ),
        const SizedBox(height: 10),
        _PrimaryButton(
          text: 'Bulk Booking',
          background: Colors.white,
          foreground: LetsBowlTheme.black,
          onTap: onBulkTap,
        ),
        const SizedBox(height: 16),
        const _HeroStatsPanel(),
      ],
    );
  }
}

class _HeroBrandIntro extends StatelessWidget {
  const _HeroBrandIntro();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _LogoBadge(size: 72),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LetsBowl',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: LetsBowlTheme.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Premium bowling, arcade, cafe and celebration venue',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: LetsBowlTheme.muted,
                  fontSize: 13.6,
                  height: 1.45,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroMainCopy extends StatelessWidget {
  const _HeroMainCopy({required this.isWide});

  final bool isWide;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TOP-NOTCH ENTERTAINMENT\nDESIGNED TO IMPRESS',
          style: TextStyle(
            color: LetsBowlTheme.white,
            fontSize: isWide ? 52 : 34,
            height: 1.02,
            fontWeight: FontWeight.w900,
            letterSpacing: -.8,
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: const Text(
            'Completely rebuilt with stronger layout structure, better line lengths, cleaner text balance and a more premium visual hierarchy in red, white, gold and black.',
            style: TextStyle(
              color: LetsBowlTheme.muted,
              fontSize: 15.6,
              height: 1.7,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroVideoBackground extends StatefulWidget {
  const _HeroVideoBackground(this.videoUrl);

  final String videoUrl;

  @override
  State<_HeroVideoBackground> createState() => _HeroVideoBackgroundState();
}

class _HeroVideoBackgroundState extends State<_HeroVideoBackground>
    with WidgetsBindingObserver {
  VideoPlayerController? _controller;
  bool _hasError = false;
  bool _isReady = false;
  int _retryCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initVideo();
  }

  Future<void> _initVideo() async {
    try {
      final controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );

      await controller.initialize();
      await controller.setLooping(true);
      await controller.setVolume(0);
      await controller.play();

      if (!mounted) {
        await controller.dispose();
        return;
      }

      _controller?.dispose();
      setState(() {
        _controller = controller;
        _hasError = false;
        _isReady = true;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _hasError = true;
        _isReady = false;
      });
      if (_retryCount < 2) {
        _retryCount++;
        await Future<void>.delayed(const Duration(seconds: 2));
        if (mounted) {
          await _initVideo();
        }
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final controller = _controller;
    if (controller == null || !_isReady) return;

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      controller.pause();
    } else if (state == AppLifecycleState.resumed) {
      controller.play();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    if (_hasError) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF311014),
                  Color(0xFF101317),
                  Color(0xFF4A3812),
                ],
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(.20)),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.play_circle_fill_rounded,
                    size: 72,
                    color: LetsBowlTheme.gold,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Video could not load in-app. Keep INTERNET permission enabled in AndroidManifest.xml and verify the device can stream the mp4 URL directly.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: LetsBowlTheme.white,
                      fontSize: 13.5,
                      height: 1.55,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    if (controller == null || !controller.value.isInitialized) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2A0E11),
              Color(0xFF111317),
              Color(0xFF463511),
            ],
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: LetsBowlTheme.gold),
        ),
      );
    }

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: controller.value.size.width,
          height: controller.value.size.height,
          child: VideoPlayer(controller),
        ),
      ),
    );
  }
}

class _LogoBadge extends StatelessWidget {
  const _LogoBadge({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * .12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * .26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Color(0xFFFFF4D8)],
        ),
        border: Border.all(color: LetsBowlTheme.gold.withOpacity(.5)),
        boxShadow: [
          BoxShadow(
            color: LetsBowlTheme.gold.withOpacity(.16),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * .18),
        child: Image.network(
          LetsBowlAssets.logo,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.sports_handball_rounded,
            color: LetsBowlTheme.red,
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.icon,
    this.iconColor,
  });

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
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                color: LetsBowlTheme.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopActionButton extends StatelessWidget {
  const _TopActionButton({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
    this.icon,
    this.iconWidget,
  });

  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  final IconData? icon;
  final Widget? iconWidget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.10),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(.12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.12),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Center(
                child: iconWidget ?? Icon(icon, color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: LetsBowlTheme.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: LetsBowlTheme.muted,
                      fontSize: 12.5,
                      height: 1.35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroStatsPanel extends StatelessWidget {
  const _HeroStatsPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.08),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(.10)),
      ),
      child: const Row(
        children: [
          Expanded(child: _HeroStatItem(value: '10+', label: 'Experiences')),
          SizedBox(width: 10),
          Expanded(child: _HeroStatItem(value: '4.7', label: 'Google Rating')),
          SizedBox(width: 10),
          Expanded(child: _HeroStatItem(value: '11 PM', label: 'Open Daily')),
        ],
      ),
    );
  }
}

class _HeroStatItem extends StatelessWidget {
  const _HeroStatItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(.08)),
      ),
      child: Column(
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: LetsBowlTheme.gold,
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: LetsBowlTheme.white,
              fontSize: 12.2,
              height: 1.35,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
  });

  final String eyebrow;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow.toUpperCase(),
          style: const TextStyle(
            color: LetsBowlTheme.gold,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Text(
            title,
            style: const TextStyle(
              color: LetsBowlTheme.white,
              fontSize: 30,
              height: 1.16,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Text(
            subtitle,
            style: const TextStyle(
              color: LetsBowlTheme.muted,
              fontSize: 14.8,
              height: 1.7,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
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
      height: 280,
      child: PageView.builder(
        controller: controller,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF281014),
                    LetsBowlTheme.panel2,
                    Color(0xFF4D3A13),
                  ],
                ),
                border: Border.all(color: LetsBowlTheme.stroke),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.16),
                    blurRadius: 16,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(item.icon, color: LetsBowlTheme.red, size: 30),
                  ),
                  const Spacer(),
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: LetsBowlTheme.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.subtitle,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: LetsBowlTheme.muted,
                      fontSize: 14.2,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: LetsBowlTheme.red,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Center(
                            child: Text(
                              'Book Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: LetsBowlTheme.gold,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: LetsBowlTheme.black,
                        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [LetsBowlTheme.red, Color(0xFF99141B)],
        ),
        boxShadow: [
          BoxShadow(
            color: LetsBowlTheme.red.withOpacity(.18),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        child: Text(
          'BOWL  •  PLAY  •  DINE  •  CELEBRATE  •  BOWL  •  PLAY  •  DINE  •  CELEBRATE  •  BOWL  •  PLAY  •  DINE  •  CELEBRATE',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            letterSpacing: .5,
          ),
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
      height: 242,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            width: 292,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: LetsBowlTheme.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.16),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: LetsBowlTheme.gold.withOpacity(.22),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    item.label,
                    style: const TextStyle(
                      color: LetsBowlTheme.redDeep,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: LetsBowlTheme.black,
                    fontSize: 31,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14.2,
                    height: 1.55,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 18),
                _PrimaryButton(
                  text: 'Claim Offer',
                  background: LetsBowlTheme.black,
                  foreground: LetsBowlTheme.gold,
                  onTap: onClaimTap,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final bool isWide = width >= 900;

    final description = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'ABOUT LETSBOWL',
          style: TextStyle(
            color: LetsBowlTheme.gold,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'LetsBowl is Chennai\'s premier entertainment destination, bringing together bowling, arcade fun, snooker, group games, food and celebration spaces under one roof.',
          style: TextStyle(
            color: LetsBowlTheme.white,
            fontSize: 22,
            height: 1.45,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 14),
        Text(
          'Whether it is a family outing, birthday celebration, team event or a spontaneous evening plan, this redesigned screen now looks more polished, more premium and far more client-ready.',
          style: TextStyle(
            color: LetsBowlTheme.muted,
            fontSize: 14.8,
            height: 1.7,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _InfoChip('BOWLING'),
            _InfoChip('ARCADE'),
            _InfoChip('SNOOKER'),
            _InfoChip('CAFE'),
            _InfoChip('PARTIES'),
          ],
        ),
      ],
    );

    final highlights = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.06),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(.08)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FeatureRow(
            icon: Icons.auto_awesome_rounded,
            title: 'Premium feel',
            subtitle: 'Luxury-inspired dark presentation with sharper typography.',
          ),
          SizedBox(height: 16),
          _FeatureRow(
            icon: Icons.view_agenda_rounded,
            title: 'Cleaner spacing',
            subtitle: 'Long text blocks are controlled to avoid ugly wrapping.',
          ),
          SizedBox(height: 16),
          _FeatureRow(
            icon: Icons.verified_rounded,
            title: 'Client-ready polish',
            subtitle: 'Stronger hierarchy creates a more trustworthy first impression.',
          ),
        ],
      ),
    );

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: LetsBowlTheme.panel2,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: LetsBowlTheme.gold.withOpacity(.16)),
      ),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 10, child: SizedBox()),
                Expanded(flex: 18, child: description),
                const SizedBox(width: 18),
                Expanded(flex: 12, child: highlights),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [description, const SizedBox(height: 18), highlights],
            ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: LetsBowlTheme.gold.withOpacity(.16),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: LetsBowlTheme.gold),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: LetsBowlTheme.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: LetsBowlTheme.muted,
                  fontSize: 13.5,
                  height: 1.55,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.06),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: LetsBowlTheme.red,
          fontWeight: FontWeight.w900,
          letterSpacing: .4,
        ),
      ),
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
          title: 'Cleaner image presentation with stronger premium overlays',
          subtitle:
              'Larger cards, more balanced text placement and better contrast make the visuals feel more luxurious.',
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 290,
          child: PageView.builder(
            controller: controller,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _NetworkPhoto(item.image),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(.86),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Text(
                              item.title,
                              style: const TextStyle(
                                color: LetsBowlTheme.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item.subtitle,
                              style: const TextStyle(
                                color: LetsBowlTheme.muted,
                                fontSize: 14.2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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
      height: 270,
      child: PageView.builder(
        controller: controller,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: LetsBowlTheme.panel2,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: LetsBowlTheme.stroke),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: const BoxDecoration(
                          color: LetsBowlTheme.red,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            item.initials,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: LetsBowlTheme.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              item.meta,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: LetsBowlTheme.muted,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
                      style: const TextStyle(
                        color: LetsBowlTheme.white,
                        fontSize: 14.6,
                        height: 1.7,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Google Review',
                    style: TextStyle(
                      color: LetsBowlTheme.gold,
                      fontWeight: FontWeight.w800,
                    ),
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

class _CtaBanner extends StatelessWidget {
  const _CtaBanner({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [LetsBowlTheme.red, LetsBowlTheme.black, Color(0xFF5D4917)],
        ),
        boxShadow: [
          BoxShadow(
            color: LetsBowlTheme.red.withOpacity(.16),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'MAKE IT A MEMORY',
            style: TextStyle(
              color: LetsBowlTheme.gold,
              fontWeight: FontWeight.w800,
              letterSpacing: .8,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'BOOK YOUR NEXT FUN EXPERIENCE',
            style: TextStyle(
              color: LetsBowlTheme.white,
              fontSize: 32,
              height: 1.08,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
           ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 720),
            child: Text(
              'Birthdays, casual hangouts, date nights, group outings and team events feel more premium when the brand presentation itself looks polished and trustworthy.',
              style: TextStyle(
                color: LetsBowlTheme.muted,
                fontSize: 14.8,
                height: 1.65,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 18),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 260),
            child: _PrimaryButton(
              text: 'Reserve Your Slot',
              background: Colors.white,
              foreground: LetsBowlTheme.black,
              onTap: onTap,
            ),
          ),
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
    final width = MediaQuery.sizeOf(context).width;
    final bool isWide = width >= 960;

    final info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            _LogoBadge(size: 58),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LetsBowl',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: LetsBowlTheme.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Chennai\'s premium strike zone',
                    style: TextStyle(
                      color: LetsBowlTheme.gold,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _FooterRow(
          icon: Icons.call_rounded,
          text: '+91 85087 00000  •  +91 9040145678  •  044-24560000',
          onTap: onCallTap,
          iconColor: LetsBowlTheme.green,
        ),
        const SizedBox(height: 12),
        _FooterRow(
          iconWidget: const _NetworkIcon(LetsBowlAssets.whatsappIcon, size: 20),
          text: 'WhatsApp Us',
          onTap: onWhatsAppTap,
          iconColor: LetsBowlTheme.green,
        ),
        const SizedBox(height: 12),
        _FooterRow(
          icon: Icons.email_rounded,
          text: 'letsbowl.97@gmail.com',
          onTap: onEmailTap,
        ),
        const SizedBox(height: 12),
        _FooterRow(
          icon: Icons.location_on_rounded,
          text:
              'No 1/812, Pillaiyar Koil Street, MCN Nagar Extension, Thoraipakkam, Chennai - 600097',
          onTap: onMapTap,
        ),
        const SizedBox(height: 12),
        const Text(
          'Open daily until 11:00 PM',
          style: TextStyle(
            color: LetsBowlTheme.muted,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    final actions = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'FOLLOW US',
          style: TextStyle(
            color: LetsBowlTheme.gold,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _SocialButton(
              iconUrl: LetsBowlAssets.instagramIcon,
              label: 'Instagram',
              onTap: onInstagramTap,
            ),
            _SocialButton(
              iconUrl: LetsBowlAssets.youtubeIcon,
              label: 'YouTube',
              onTap: onYoutubeTap,
            ),
            _SocialButton(
              iconUrl: LetsBowlAssets.facebookIcon,
              label: 'Facebook',
              onTap: onFacebookTap,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _PrimaryButton(
                text: 'Call Now',
                background: LetsBowlTheme.green,
                foreground: Colors.white,
                onTap: onCallTap,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _PrimaryButton(
                text: 'WhatsApp',
                background: LetsBowlTheme.green,
                foreground: Colors.white,
                onTap: onWhatsAppTap,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _MiniActionChip(label: 'Bulk Booking', onTap: onBulkTap),
            _MiniActionChip(label: 'Party Hall', onTap: onBulkTap),
            _MiniActionChip(label: 'Tournaments', onTap: onBulkTap),
          ],
        ),
      ],
    );

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: LetsBowlTheme.panel,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: LetsBowlTheme.stroke),
      ),
      child: Column(
        children: [
          isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 16, child: info),
                    const SizedBox(width: 26),
                    Expanded(flex: 12, child: actions),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [info, const SizedBox(height: 22), actions],
                ),
          const SizedBox(height: 18),
          Divider(color: Colors.white.withOpacity(.08)),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '© 2026 LetsBowl. All rights reserved.',
              style: TextStyle(
                color: LetsBowlTheme.muted,
                fontSize: 12.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterRow extends StatelessWidget {
  const _FooterRow({
    required this.text,
    required this.onTap,
    this.icon,
    this.iconWidget,
    this.iconColor,
  });

  final String text;
  final VoidCallback onTap;
  final IconData? icon;
  final Widget? iconWidget;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 22,
            child: iconWidget ??
                Icon(
                  icon,
                  color: iconColor ?? LetsBowlTheme.gold,
                  size: 20,
                ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: LetsBowlTheme.white,
                height: 1.6,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.iconUrl,
    required this.label,
    required this.onTap,
  });

  final String iconUrl;
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
          color: Colors.white.withOpacity(.06),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white.withOpacity(.08)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _NetworkIcon(iconUrl, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: LetsBowlTheme.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
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
        child: Text(
          label,
          style: const TextStyle(
            color: LetsBowlTheme.black,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.text,
    required this.background,
    required this.foreground,
    required this.onTap,
  });

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
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: foreground,
                fontWeight: FontWeight.w800,
                fontSize: 14.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatingActionRail extends StatelessWidget {
  const _FloatingActionRail({
    required this.onWhatsAppTap,
    required this.onCallTap,
  });

  final VoidCallback onWhatsAppTap;
  final VoidCallback onCallTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton.small(
          heroTag: 'whatsapp_fab',
          backgroundColor: LetsBowlTheme.green,
          onPressed: onWhatsAppTap,
          child: const _NetworkIcon(LetsBowlAssets.whatsappIcon, size: 22),
        ),
        const SizedBox(height: 12),
        FloatingActionButton(
          heroTag: 'call_fab',
          backgroundColor: LetsBowlTheme.green,
          onPressed: onCallTap,
          child: const Icon(Icons.call_rounded, color: Colors.white),
        ),
      ],
    );
  }
}

class _NetworkIcon extends StatelessWidget {
  const _NetworkIcon(this.url, {required this.size});

  final String url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Icon(
        Icons.public,
        size: size,
        color: LetsBowlTheme.white,
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
      errorBuilder: (_, __, ___) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF2B1518), Color(0xFF0E0E0E), Color(0xFF443410)],
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.image_not_supported_rounded,
              color: LetsBowlTheme.gold,
              size: 42,
            ),
          ),
        );
      },
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          color: LetsBowlTheme.panel2,
          child: const Center(
            child: CircularProgressIndicator(color: LetsBowlTheme.gold),
          ),
        );
      },
    );
  }
}
