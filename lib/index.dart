import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
  static const Color black = Color(0xFF0B0B0B);
  static const Color softBlack = Color(0xFF171717);
  static const Color cardBlack = Color(0xFF121212);
  static const Color white = Color(0xFFF8F5EF);
  static const Color pureWhite = Colors.white;
  static const Color red = Color(0xFFC51623);
  static const Color darkRed = Color(0xFF7E0E16);
  static const Color gold = Color(0xFFD4AF37);
  static const Color deepGold = Color(0xFF8E6B12);
  static const Color muted = Color(0xFFBBBBBB);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: black,
      colorScheme: const ColorScheme.dark(
        primary: red,
        secondary: gold,
        surface: softBlack,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: black,
        elevation: 0,
        centerTitle: true,
      ),
      fontFamily: 'Roboto',
    );
  }
}

class LetsBowlLinks {
  static final Uri callPrimary = Uri.parse('tel:+918508700000');
  static final Uri whatsapp = Uri.parse('https://wa.me/918508700000');
  static final Uri bulkBooking = Uri.parse('https://wa.me/918508700000?text=Hi%20LetsBowl%2C%20I%20want%20to%20enquire%20about%20bulk%20booking.');
  static final Uri reserveSlot = Uri.parse('https://wa.me/918508700000?text=Hi%20LetsBowl%2C%20I%20want%20to%20reserve%20a%20slot.');
  static final Uri email = Uri.parse('mailto:letsbowl.97@gmail.com');
  static final Uri maps = Uri.parse('https://maps.google.com/?q=No%201/812,%20Pillaiyar%20Koil%20Street,%20MCN%20Nagar%20Extension,%20Thoraipakkam,%20Chennai%20-%20600097');
  static final Uri instagram = Uri.parse('https://www.instagram.com/');
  static final Uri facebook = Uri.parse('https://www.facebook.com/');
  static final Uri youtube = Uri.parse('https://www.youtube.com/');
}

class LetsBowlHomeScreen extends StatefulWidget {
  const LetsBowlHomeScreen({super.key});

  @override
  State<LetsBowlHomeScreen> createState() => _LetsBowlHomeScreenState();
}

class _LetsBowlHomeScreenState extends State<LetsBowlHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final PageController _galleryController = PageController(viewportFraction: 0.82);
  final PageController _reviewController = PageController(viewportFraction: 0.9);
  Timer? _galleryTimer;
  Timer? _reviewTimer;
  int _galleryIndex = 0;
  int _reviewIndex = 0;

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _offersKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _galleryKey = GlobalKey();
  final GlobalKey _reviewsKey = GlobalKey();
  final GlobalKey _footerKey = GlobalKey();

  static const List<ActivityItem> activities = [
    ActivityItem('01', 'Bowling', Icons.sports_handball_rounded),
    ActivityItem('02', 'Snooker', Icons.sports_bar_rounded),
    ActivityItem('03', 'Arcade', Icons.videogame_asset_rounded),
    ActivityItem('04', 'Machine Cricket', Icons.sports_cricket_rounded),
    ActivityItem('05', 'Badminton', Icons.sports_tennis_rounded),
    ActivityItem('06', 'PickleBall', Icons.sports_baseball_rounded),
    ActivityItem('07', 'Table Tennis', Icons.sports_tennis_rounded),
    ActivityItem('08', 'Party Hall', Icons.celebration_rounded),
    ActivityItem('09', 'Chill-Pill Games', Icons.extension_rounded),
    ActivityItem('10', 'Cafe', Icons.local_cafe_rounded),
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
    ReviewItem(
      initials: 'AK',
      name: 'Aravind Kalyan',
      meta: 'Local Guide • a month ago',
      text: 'Had a very great time at Let\'s Bowl, Thoraipakkam. Bowling alley, party space, VR arena and cafe under one roof.',
    ),
    ReviewItem(
      initials: 'MA',
      name: 'Mohammed Affrudin',
      meta: 'Local Guide • 2 months ago',
      text: 'Awesome time at the bowling cafe. The lanes were smooth, well-maintained, and some of the best I\'ve played on.',
    ),
    ReviewItem(
      initials: 'RR',
      name: 'Rahul R',
      meta: 'Local Guide • recently',
      text: 'A good place to try something different from regular indoor games. Bowling was fun and beginner friendly.',
    ),
    ReviewItem(
      initials: 'JM',
      name: 'James M',
      meta: 'recently',
      text: 'Very good place for team fun activities. The VR roller coaster and zombie game were realistic and thrilling.',
    ),
    ReviewItem(
      initials: 'AS',
      name: 'ameen shamshir',
      meta: 'Local Guide • recently',
      text: 'Fun-filled experience with a great atmosphere. Perfect for group games and outings. Helpful staff too.',
    ),
  ];

  static const List<GalleryItem> galleryItems = [
    GalleryItem('Bowling Lanes', Icons.sports_handball_rounded),
    GalleryItem('Arcade Zone', Icons.videogame_asset_rounded),
    GalleryItem('Snooker Tables', Icons.sports_bar_rounded),
    GalleryItem('Machine Cricket', Icons.sports_cricket_rounded),
    GalleryItem('Party Hall', Icons.celebration_rounded),
    GalleryItem('Cafe', Icons.local_cafe_rounded),
    GalleryItem('Group Fun', Icons.groups_rounded),
    GalleryItem('Family Time', Icons.favorite_rounded),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _galleryTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_galleryController.hasClients) return;
      _galleryIndex = (_galleryIndex + 1) % galleryItems.length;
      _galleryController.animateToPage(
        _galleryIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });

    _reviewTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_reviewController.hasClients) return;
      _reviewIndex = (_reviewIndex + 1) % reviews.length;
      _reviewController.animateToPage(
        _reviewIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _galleryController.dispose();
    _reviewController.dispose();
    _galleryTimer?.cancel();
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
        onPartyTap: () => _scrollTo(_offersKey),
        onTournamentsTap: () => _scrollTo(_reviewsKey),
        onBulkBookingTap: () => _open(LetsBowlLinks.bulkBooking),
        onAboutTap: () => _scrollTo(_aboutKey),
        onQuickLinksTap: () => _scrollTo(_footerKey),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: LetsBowlTheme.black,
            toolbarHeight: 74,
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
                const SizedBox(height: 10),
                _SocialStrip(
                  onFacebookTap: () => _open(LetsBowlLinks.facebook),
                  onInstagramTap: () => _open(LetsBowlLinks.instagram),
                  onYoutubeTap: () => _open(LetsBowlLinks.youtube),
                ),
                const SizedBox(height: 10),
                _TopContactCard(
                  onCallTap: () => _open(LetsBowlLinks.callPrimary),
                  onWhatsAppTap: () => _open(LetsBowlLinks.whatsapp),
                  onBulkBookingTap: () => _open(LetsBowlLinks.bulkBooking),
                  onPartyTap: () => _scrollTo(_offersKey),
                  onTournamentTap: () => _scrollTo(_reviewsKey),
                ),
                const SizedBox(height: 14),
                Container(
                  key: _heroKey,
                  child: _HeroSection(
                    onBookNowTap: () => _open(LetsBowlLinks.reserveSlot),
                    onExploreTap: () => _scrollTo(_aboutKey),
                  ),
                ),
                const SizedBox(height: 24),
                const _SectionHeader(
                  eyebrow: 'What We Offer',
                  title: '10 ways to have fun under one roof',
                  subtitle: 'Home screen rebuilt from the LetsBowl site with a white, red, gold and black premium mobile theme.',
                ),
                const SizedBox(height: 16),
                _ActivitiesGrid(
                  items: activities,
                  onItemTap: (item) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item.title} tapped')),
                    );
                  },
                ),
                const SizedBox(height: 18),
                const _TickerBand(),
                const SizedBox(height: 24),
                Container(
                  key: _offersKey,
                  child: const _SectionHeader(
                    eyebrow: 'Live Offers',
                    title: 'Grab these deals before they\'re gone',
                    subtitle: 'Offer cards, swipe behavior and action buttons based on the website\'s promotions section.',
                  ),
                ),
                const SizedBox(height: 16),
                _OffersCarousel(
                  items: offers,
                  onClaimTap: () => _open(LetsBowlLinks.whatsapp),
                ),
                const SizedBox(height: 24),
                Container(
                  key: _aboutKey,
                  child: const _AboutSection(),
                ),
                const SizedBox(height: 24),
                Container(
                  key: _galleryKey,
                  child: _GallerySection(
                    controller: _galleryController,
                    items: galleryItems,
                    onViewGalleryTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Open full gallery screen here')),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  key: _reviewsKey,
                  child: const _SectionHeader(
                    eyebrow: 'What People Say',
                    title: '4.7 on Google Maps',
                    subtitle: 'Auto-sliding review cards inspired by the live review section on the website.',
                  ),
                ),
                const SizedBox(height: 16),
                _ReviewsSection(controller: _reviewController, items: reviews),
                const SizedBox(height: 24),
                _FinalCta(onTap: () => _open(LetsBowlLinks.reserveSlot)),
                const SizedBox(height: 24),
                Container(
                  key: _footerKey,
                  child: _FooterSection(
                    onCallTap: () => _open(LetsBowlLinks.callPrimary),
                    onWhatsAppTap: () => _open(LetsBowlLinks.whatsapp),
                    onEmailTap: () => _open(LetsBowlLinks.email),
                    onMapsTap: () => _open(LetsBowlLinks.maps),
                    onFacebookTap: () => _open(LetsBowlLinks.facebook),
                    onInstagramTap: () => _open(LetsBowlLinks.instagram),
                    onYoutubeTap: () => _open(LetsBowlLinks.youtube),
                    onBulkBookingTap: () => _open(LetsBowlLinks.bulkBooking),
                    onPartyTap: () => _scrollTo(_offersKey),
                    onTournamentsTap: () => _scrollTo(_reviewsKey),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: 'whatsapp',
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

class ActivityItem {
  final String index;
  final String title;
  final IconData icon;

  const ActivityItem(this.index, this.title, this.icon);
}

class OfferItem {
  final String tag;
  final String title;
  final String desc;

  const OfferItem(this.tag, this.title, this.desc);
}

class ReviewItem {
  final String initials;
  final String name;
  final String meta;
  final String text;

  const ReviewItem({required this.initials, required this.name, required this.meta, required this.text});
}

class GalleryItem {
  final String title;
  final IconData icon;

  const GalleryItem(this.title, this.icon);
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer({
    required this.onPartyTap,
    required this.onTournamentsTap,
    required this.onBulkBookingTap,
    required this.onAboutTap,
    required this.onQuickLinksTap,
  });

  final VoidCallback onPartyTap;
  final VoidCallback onTournamentsTap;
  final VoidCallback onBulkBookingTap;
  final VoidCallback onAboutTap;
  final VoidCallback onQuickLinksTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: LetsBowlTheme.softBlack,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'LetsBowl',
                style: TextStyle(color: LetsBowlTheme.pureWhite, fontSize: 24, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 4),
              const Text(
                'Chennai\'s Strike Zone',
                style: TextStyle(color: LetsBowlTheme.gold, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 24),
              _DrawerTile(icon: Icons.celebration_rounded, text: 'Party', onTap: onPartyTap),
              _DrawerTile(icon: Icons.emoji_events_rounded, text: 'Tournaments', onTap: onTournamentsTap),
              _DrawerTile(icon: Icons.groups_rounded, text: 'Bulk Booking', onTap: onBulkBookingTap),
              _DrawerTile(icon: Icons.info_outline_rounded, text: 'About', onTap: onAboutTap),
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
        color: LetsBowlTheme.cardBlack,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
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

class _SocialStrip extends StatelessWidget {
  const _SocialStrip({required this.onFacebookTap, required this.onInstagramTap, required this.onYoutubeTap});

  final VoidCallback onFacebookTap;
  final VoidCallback onInstagramTap;
  final VoidCallback onYoutubeTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Text('follow us on:', style: TextStyle(color: LetsBowlTheme.muted, fontSize: 12)),
          const Spacer(),
          _CircleIcon(icon: Icons.facebook_rounded, onTap: onFacebookTap),
          const SizedBox(width: 8),
          _CircleIcon(icon: Icons.camera_alt_rounded, onTap: onInstagramTap),
          const SizedBox(width: 8),
          _CircleIcon(icon: Icons.play_arrow_rounded, onTap: onYoutubeTap),
        ],
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  const _CircleIcon({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(99),
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: LetsBowlTheme.softBlack,
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Icon(icon, color: LetsBowlTheme.gold, size: 18),
      ),
    );
  }
}

class _TopContactCard extends StatelessWidget {
  const _TopContactCard({
    required this.onCallTap,
    required this.onWhatsAppTap,
    required this.onBulkBookingTap,
    required this.onPartyTap,
    required this.onTournamentTap,
  });

  final VoidCallback onCallTap;
  final VoidCallback onWhatsAppTap;
  final VoidCallback onBulkBookingTap;
  final VoidCallback onPartyTap;
  final VoidCallback onTournamentTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: LetsBowlTheme.softBlack,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: LetsBowlTheme.gold.withOpacity(0.14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.circle, size: 10, color: Colors.greenAccent),
              SizedBox(width: 8),
              Text('Open Now!', style: TextStyle(color: LetsBowlTheme.gold, fontWeight: FontWeight.w800)),
              Spacer(),
              Text('Until 11:00 PM', style: TextStyle(color: LetsBowlTheme.pureWhite, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'letsbowl.97@gmail.com  •  +91 85087 00000',
            style: TextStyle(color: LetsBowlTheme.muted, fontSize: 12.5, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _QuickChip(label: 'Bulk Booking', onTap: onBulkBookingTap, color: LetsBowlTheme.gold, textColor: LetsBowlTheme.black),
              _QuickChip(label: 'Party', onTap: onPartyTap, color: LetsBowlTheme.cardBlack, textColor: LetsBowlTheme.pureWhite),
              _QuickChip(label: 'Tournaments', onTap: onTournamentTap, color: LetsBowlTheme.cardBlack, textColor: LetsBowlTheme.pureWhite),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _PillButton(text: 'Call Now', bgColor: LetsBowlTheme.red, textColor: LetsBowlTheme.pureWhite, onTap: onCallTap)),
              const SizedBox(width: 10),
              Expanded(child: _PillButton(text: 'WhatsApp', bgColor: LetsBowlTheme.gold, textColor: LetsBowlTheme.black, onTap: onWhatsAppTap)),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickChip extends StatelessWidget {
  const _QuickChip({required this.label, required this.onTap, required this.color, required this.textColor});

  final String label;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white.withOpacity(0.06)),
        ),
        child: Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.w700)),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.onBookNowTap, required this.onExploreTap});

  final VoidCallback onBookNowTap;
  final VoidCallback onExploreTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A1A1A), LetsBowlTheme.darkRed, LetsBowlTheme.black],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -16,
            top: 0,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [LetsBowlTheme.gold.withOpacity(0.66), LetsBowlTheme.gold.withOpacity(0.03)],
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.12)),
                ),
                child: const Text(
                  'Premium Entertainment Destination',
                  style: TextStyle(color: LetsBowlTheme.gold, fontWeight: FontWeight.w700, fontSize: 12),
                ),
              ),
              const Spacer(),
              const Text(
                'CHENNAI\'S\nSTRIKE ZONE',
                style: TextStyle(
                  color: LetsBowlTheme.pureWhite,
                  fontSize: 38,
                  height: 1.04,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Premium bowling, arcade, snooker & more. Your ultimate entertainment destination in the heart of Chennai.',
                style: TextStyle(color: LetsBowlTheme.white, fontSize: 15, height: 1.45, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(child: _PillButton(text: 'Book Now', bgColor: LetsBowlTheme.red, textColor: LetsBowlTheme.pureWhite, onTap: onBookNowTap)),
                  const SizedBox(width: 10),
                  Expanded(child: _PillButton(text: 'Explore', bgColor: LetsBowlTheme.pureWhite, textColor: LetsBowlTheme.black, onTap: onExploreTap)),
                ],
              ),
              const SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Scroll', style: TextStyle(color: LetsBowlTheme.gold, fontWeight: FontWeight.w800)),
                      SizedBox(height: 4),
                      Text('to discover', style: TextStyle(color: LetsBowlTheme.muted, fontSize: 12)),
                    ],
                  ),
                  Row(
                    children: List.generate(
                      3,
                      (index) => Transform.translate(
                        offset: Offset(index == 0 ? 0 : -10.0 * index, 0),
                        child: Container(
                          width: 34 + (index * 7),
                          height: 34 + (index * 7),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(colors: [LetsBowlTheme.pureWhite, LetsBowlTheme.gold, LetsBowlTheme.deepGold]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
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
            style: const TextStyle(color: LetsBowlTheme.pureWhite, fontSize: 25, height: 1.15, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(color: LetsBowlTheme.muted, fontSize: 14, height: 1.45, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _ActivitiesGrid extends StatelessWidget {
  const _ActivitiesGrid({required this.items, required this.onItemTap});

  final List<ActivityItem> items;
  final ValueChanged<ActivityItem> onItemTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          mainAxisExtent: 155,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return InkWell(
            borderRadius: BorderRadius.circular(22),
            onTap: () => onItemTap(item),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: LetsBowlTheme.softBlack,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withOpacity(0.07)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(item.index, style: const TextStyle(color: LetsBowlTheme.gold, fontSize: 24, fontWeight: FontWeight.w900)),
                      const Spacer(),
                      Icon(item.icon, color: LetsBowlTheme.red),
                    ],
                  ),
                  const Spacer(),
                  Text(item.title, style: const TextStyle(color: LetsBowlTheme.pureWhite, fontSize: 18, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Text('Book Now', style: TextStyle(color: LetsBowlTheme.red, fontWeight: FontWeight.w800)),
                      SizedBox(width: 2),
                      Icon(Icons.arrow_right_alt_rounded, color: LetsBowlTheme.red),
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

class _TickerBand extends StatelessWidget {
  const _TickerBand();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: LetsBowlTheme.red,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: const Text(
        'EAT • PLAY • BOWL • REPEAT • EAT • PLAY • BOWL • REPEAT • EAT • PLAY • BOWL • REPEAT • EAT • PLAY • BOWL • REPEAT',
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
        style: TextStyle(color: LetsBowlTheme.pureWhite, fontWeight: FontWeight.w900, letterSpacing: 0.4),
      ),
    );
  }
}

class _OffersCarousel extends StatelessWidget {
  const _OffersCarousel({required this.items, required this.onClaimTap});

  final List<OfferItem> items;
  final VoidCallback onClaimTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            width: 260,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: LetsBowlTheme.pureWhite,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.tag, style: const TextStyle(color: LetsBowlTheme.deepGold, fontWeight: FontWeight.w800, fontSize: 12)),
                const SizedBox(height: 10),
                Text(item.title, style: const TextStyle(color: LetsBowlTheme.black, fontWeight: FontWeight.w900, fontSize: 25)),
                const SizedBox(height: 10),
                Text(item.desc, style: const TextStyle(color: LetsBowlTheme.cardBlack, height: 1.4, fontWeight: FontWeight.w500)),
                const Spacer(),
                _PillButton(text: 'Claim Offer', bgColor: LetsBowlTheme.black, textColor: LetsBowlTheme.gold, onTap: onClaimTap),
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: LetsBowlTheme.softBlack,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: LetsBowlTheme.gold.withOpacity(0.15)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About Us', style: TextStyle(color: LetsBowlTheme.gold, fontWeight: FontWeight.w800)),
          SizedBox(height: 12),
          Text(
            'LetsBowl is Chennai\'s premier entertainment destination, bringing together world-class bowling lanes, an exciting arcade zone, professional snooker tables, and a vibrant cafe all under one roof. Whether you\'re planning a family outing, a corporate event, or just a fun day with friends, we\'ve got you covered.',
            style: TextStyle(color: LetsBowlTheme.pureWhite, fontSize: 16, height: 1.55, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 14),
          Text(
            'BOWLING • ARCADE • SNOOKER • CAFE • PARTY',
            style: TextStyle(color: LetsBowlTheme.red, fontWeight: FontWeight.w900, letterSpacing: 0.4),
          ),
        ],
      ),
    );
  }
}

class _GallerySection extends StatelessWidget {
  const _GallerySection({required this.controller, required this.items, required this.onViewGalleryTap});

  final PageController controller;
  final List<GalleryItem> items;
  final VoidCallback onViewGalleryTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(
          eyebrow: 'Gallery',
          title: 'A visual preview of the venue',
          subtitle: 'Swipeable gallery cards. You can later replace these placeholders with the live LetsBowl image URLs or your own CDN images.',
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 230,
          child: PageView.builder(
            controller: controller,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF2A2A2A), LetsBowlTheme.darkRed, Color(0xFF3C2E14)],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -10,
                        top: -20,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: LetsBowlTheme.gold.withOpacity(0.12),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(item.icon, color: LetsBowlTheme.gold, size: 42),
                            const Spacer(),
                            Text(item.title, style: const TextStyle(color: LetsBowlTheme.pureWhite, fontSize: 24, fontWeight: FontWeight.w900)),
                            const SizedBox(height: 6),
                            const Text('Gallery preview card', style: TextStyle(color: LetsBowlTheme.white)),
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
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            child: _PillButton(text: 'View Full Gallery', bgColor: LetsBowlTheme.gold, textColor: LetsBowlTheme.black, onTap: onViewGalleryTap),
          ),
        ),
      ],
    );
  }
}

class _ReviewsSection extends StatelessWidget {
  const _ReviewsSection({required this.controller, required this.items});

  final PageController controller;
  final List<ReviewItem> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: PageView.builder(
        controller: controller,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: LetsBowlTheme.softBlack,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
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
                            const SizedBox(height: 3),
                            Text(item.meta, style: const TextStyle(color: LetsBowlTheme.muted, fontSize: 12)),
                          ],
                        ),
                      ),
                      const Icon(Icons.star_rounded, color: LetsBowlTheme.gold),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    item.text,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: LetsBowlTheme.white, height: 1.5, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  const Text('Google', style: TextStyle(color: LetsBowlTheme.gold, fontWeight: FontWeight.w800, fontSize: 12)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FinalCta extends StatelessWidget {
  const _FinalCta({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(colors: [LetsBowlTheme.red, LetsBowlTheme.black, LetsBowlTheme.deepGold]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('THE PLACE WHERE', style: TextStyle(color: LetsBowlTheme.gold, fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          const Text(
            'MEMORIES ARE MADE',
            style: TextStyle(color: LetsBowlTheme.pureWhite, fontSize: 31, height: 1.08, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          const Text(
            'From birthday parties to corporate team-building, from casual hangouts to competitive tournaments, LetsBowl is where Chennai comes to play.',
            style: TextStyle(color: LetsBowlTheme.white, height: 1.5, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 18),
          _PillButton(text: 'Reserve Your Slot', bgColor: LetsBowlTheme.pureWhite, textColor: LetsBowlTheme.black, onTap: onTap),
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
    required this.onMapsTap,
    required this.onFacebookTap,
    required this.onInstagramTap,
    required this.onYoutubeTap,
    required this.onBulkBookingTap,
    required this.onPartyTap,
    required this.onTournamentsTap,
  });

  final VoidCallback onCallTap;
  final VoidCallback onWhatsAppTap;
  final VoidCallback onEmailTap;
  final VoidCallback onMapsTap;
  final VoidCallback onFacebookTap;
  final VoidCallback onInstagramTap;
  final VoidCallback onYoutubeTap;
  final VoidCallback onBulkBookingTap;
  final VoidCallback onPartyTap;
  final VoidCallback onTournamentsTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: LetsBowlTheme.cardBlack, borderRadius: BorderRadius.circular(28)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('LetsBowl', style: TextStyle(color: LetsBowlTheme.pureWhite, fontSize: 24, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          const Text('Chennai\'s Strike Zone', style: TextStyle(color: LetsBowlTheme.gold, fontWeight: FontWeight.w700)),
          const SizedBox(height: 18),
          _FooterRow(icon: Icons.call_rounded, text: '+91 85087 00000  •  +91 9040145678  •  044-24560000', onTap: onCallTap),
          const SizedBox(height: 10),
          _FooterRow(icon: Icons.chat_rounded, text: 'WhatsApp Us', onTap: onWhatsAppTap),
          const SizedBox(height: 10),
          _FooterRow(icon: Icons.email_rounded, text: 'letsbowl.97@gmail.com', onTap: onEmailTap),
          const SizedBox(height: 10),
          _FooterRow(icon: Icons.location_on_rounded, text: 'No 1/812, Pillaiyar Koil Street, MCN Nagar Extension, Thoraipakkam, Chennai - 600097', onTap: onMapsTap),
          const SizedBox(height: 10),
          const Text('Open Daily until 11:00 PM', style: TextStyle(color: LetsBowlTheme.muted, fontWeight: FontWeight.w600)),
          const SizedBox(height: 18),
          const Text('Follow Us', style: TextStyle(color: LetsBowlTheme.gold, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          Row(
            children: [
              _CircleIcon(icon: Icons.camera_alt_rounded, onTap: onInstagramTap),
              const SizedBox(width: 8),
              _CircleIcon(icon: Icons.play_arrow_rounded, onTap: onYoutubeTap),
              const SizedBox(width: 8),
              _CircleIcon(icon: Icons.facebook_rounded, onTap: onFacebookTap),
            ],
          ),
          const SizedBox(height: 18),
          const Text('Quick Links', style: TextStyle(color: LetsBowlTheme.gold, fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _QuickChip(label: 'Bulk Booking', onTap: onBulkBookingTap, color: LetsBowlTheme.gold, textColor: LetsBowlTheme.black),
              _QuickChip(label: 'Party Hall', onTap: onPartyTap, color: LetsBowlTheme.softBlack, textColor: LetsBowlTheme.pureWhite),
              _QuickChip(label: 'Tournaments', onTap: onTournamentsTap, color: LetsBowlTheme.softBlack, textColor: LetsBowlTheme.pureWhite),
            ],
          ),
          const SizedBox(height: 18),
          Divider(color: Colors.white.withOpacity(0.1)),
          const SizedBox(height: 10),
          const Text('© 2026 LetsBowl. All rights reserved.', style: TextStyle(color: LetsBowlTheme.muted, fontSize: 12)),
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
          Expanded(child: Text(text, style: const TextStyle(color: LetsBowlTheme.white, height: 1.45, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({required this.text, required this.bgColor, required this.textColor, required this.onTap});

  final String text;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Center(
            child: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.w800, fontSize: 14)),
          ),
        ),
      ),
    );
  }
}
