import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF060112),
        fontFamily: 'sans-serif',
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // المحتوى القابل للتمرير
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 100), // مساحة لتعويض الـ Navbar الثابت
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    padding: EdgeInsets.symmetric(horizontal: width > 600 ? 40 : 20),
                    child: Column(
                      children: [
                        HeroSection(key: _homeKey),
                        const SizedBox(height: 100),
                        const TechStackSection(),
                        const SizedBox(height: 150),
                        WorkExperienceSection(key: _aboutKey),
                        const SizedBox(height: 150),
                        FeaturedProjectsSection(key: _projectsKey),
                        const SizedBox(height: 150),
                        ContactSection(key: _contactKey),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Navbar الثابت في الأعلى
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF060112).withValues(alpha: 0.9), // خلفية شبه شفافة
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Navbar(
                onHomeTap: () => _scrollToSection(_homeKey),
                onAboutTap: () => _scrollToSection(_aboutKey),
                onProjectsTap: () => _scrollToSection(_projectsKey),
                onContactTap: () => _scrollToSection(_contactKey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Navbar extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  const Navbar({
    super.key,
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onProjectsTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Σ", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white)),
          if (MediaQuery.of(context).size.width > 700)
            Row(
              children: [
                _navItem("Home", onHomeTap),
                _navItem("Work Experience", onAboutTap),
                _navItem("Projects", onProjectsTap),
                _navItem("Contact", onContactTap),
              ],
            )
          else
            const Icon(Icons.menu, color: Colors.white),
        ],
      ),
    );
  }

  Widget _navItem(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, color: Colors.white70, fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: const Color(0xFF6C35DE).withValues(alpha: 0.3), blurRadius: 150, spreadRadius: 30),
                ],
              ),
            ),
            Column(
              children: [
                const Text("Hello! I Am Yousef Ahmad", style: TextStyle(color: Color(0xFFC084FC), fontSize: 16)),
                const SizedBox(height: 20),
                Image.asset(
                  'me.png',
                  height: 220,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person, size: 100, color: Colors.white24);
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 40),
        const Text(
          "I'm a Software Engineer.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, height: 1.1, color: Colors.white),
        ),
        const SizedBox(height: 60),
        const Text(
          "Currently, I'm a Software Engineer at Domedia",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        const Text(
          "Flutter Developer & Backend Engineer with 4+ years of experience delivering scalable mobile and backend solutions.\n Specialized in API development and Odoo systems, with a strong emphasis on performance, reliability, and business alignment.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
      ],
    );
  }
}

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "I am currently seeking to join a cross-functional team that is passionate about building scalable digital\n products and improving people's lives through accessible, high-quality technology.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white70),
        ),
        const SizedBox(height: 80),
        SizedBox(
          height: 400,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(double.infinity, 400),
                painter: LinesPainter(),
              ),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF1A0B3C),
                  boxShadow: [
                    BoxShadow(color: const Color(0xFF6C35DE).withValues(alpha: 0.6), blurRadius: 80, spreadRadius: 10),
                  ],
                ),
                child: const Center(child: Text("Σ", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold))),
              ),
              _positionedIcon(0, -150, Icons.code, Colors.blue), // Flutter/Dart
              _positionedIcon(120, -100, Icons.terminal, Colors.greenAccent), // Python
              _positionedIcon(-120, -100, Icons.html, Colors.orange), // HTML
              _positionedIcon(180, 0, Icons.storage, Colors.blueGrey), // Database
              _positionedIcon(-180, 0, Icons.description, Colors.orangeAccent), // XML
              _positionedIcon(120, 100, Icons.css, Colors.blueAccent), // CSS
              _positionedIcon(-120, 100, Icons.javascript, Colors.yellow), // JS
              _positionedIcon(0, 150, Icons.data_array, Colors.green), // Logic/Data
            ],
          ),
        ),
      ],
    );
  }

  Widget _positionedIcon(double x, double y, IconData icon, Color color) {
    return Transform.translate(
      offset: Offset(x, y),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white10,
        child: Icon(icon, color: color, size: 30),
      ),
    );
  }
}

class LinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF6C35DE).withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    var center = Offset(size.width / 2, size.height / 2);
    for (var i = 0; i < 8; i++) {
      var path = Path();
      path.moveTo(center.dx, center.dy);
      path.lineTo(center.dx + 150 * (i == 0 || i == 4 ? 0 : (i < 4 ? 1 : -1)), 
                  center.dy + 150 * (i == 2 || i == 6 ? 0 : (i > 0 && i < 4 ? -1 : 1)));
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WorkExperienceSection extends StatelessWidget {
  const WorkExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Work Experience", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
        const SizedBox(height: 50),
        LayoutBuilder(builder: (context, constraints) {
          int count = constraints.maxWidth > 800 ? 2 : 1;
          return GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: count,
            childAspectRatio: 2.5,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
            children: [
              _expCard(
                const Color(0xFF2E1065), 
                Icons.phone_android, 
                "Domedia", 
                "Leading Flutter development and building scalable backend solutions with Odoo integration.",
                "https://domedia.me"
              ),
              _expCard(
                const Color(0xFF1E1B4B), 
                Icons.lightbulb_outline, 
                "Trackware", 
                "Specialized in crafting robust mobile applications and custom Odoo modules to streamline workflows.",
                "https://trackware.com"
              ),
              _expCard(
                const Color(0xFF4C1D95), 
                Icons.coffee_outlined, 
                "DCT TECHNOLOGY", 
                "Developing high-performance mobile apps and optimized API architectures for seamless experiences.",
                ""
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _expCard(Color bgColor, IconData icon, String title, String dec, String website) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [bgColor, bgColor.withValues(alpha: 0.5)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white10),
      ),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Icon(icon, size: 45, color: const Color(0xFFC084FC)),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(dec, style: const TextStyle(color: Colors.white70, fontSize: 13), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () async {
                    if (website.isNotEmpty) {
                      final Uri url = Uri.parse(website);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url, mode: LaunchMode.externalApplication);
                      }
                    }
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.white10),
                  child: const Text("LEARN MORE", style: TextStyle(fontSize: 11, color: Colors.white)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FeaturedProjectsSection extends StatelessWidget {
  const FeaturedProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _projectRow(
          true, 
          "01", 
          "Ain FM", 
          "Developed the Ain FM mobile application for both Android and iOS platforms, focusing on seamless API integration to deliver a robust and high-performance user experience.",
          "https://play.google.com/store/apps/details?id=com.domediaJo.radioAin&pli=1", 
          "https://apps.apple.com/us/app/radio-ain-fm/id6746383493",       
          "https://ainfm.com" ,             
          "ainfm98.png", Colors.white
        ),
        const SizedBox(height: 180),
        _projectRow(
            true,
          "02", 
          "Aldar News", 
          "Developed the comprehensive admin dashboard and architected the backend API, focusing on efficient content management and high-performance data delivery for the news platform.",
          "", "", "https://aldarnews.net/", "aldar.png", Colors.white
        ),
        const SizedBox(height: 180),
        _projectRow(
            true,
            "03",
            "Trackware School Management",
            "Developed the Trackware School Management mobile application for both Android and iOS platforms, focusing on architecting robust backend APIs and ensuring seamless integration to deliver a high-performance user experience.",
            "https://play.google.com/store/apps/details?id=trackware.schoolparenttrackware.parent&hl=en",
            "https://apps.apple.com/app/trackware-school/id1183244199",
            "" ,
            "trackwareB.jpeg",
            const Color(0xFF1A1A2E).withValues(alpha: 0.95)
        ),
        const SizedBox(height: 180),
        _projectRow(
            true,
            "04",
            "Trackware - School Bus Driver",
            "Developed the Trackware - School Bus Driver mobile application for Android platform, focusing on architecting robust backend APIs and ensuring seamless integration to deliver a high-performance user experience.",
            "https://play.google.com/store/apps/details?id=trackware.schoolbustracker.driver&hl=en",
            "",
            "" ,
            "trackwareB.jpeg",
            const Color(0xFF1A1A2E).withValues(alpha: 0.95)
        ),
        const SizedBox(height: 180),
        _projectRow(
            false,
            "05",
            "Trackware School Management (Odoo)",
            "Developed and customized specialized Odoo modules for school management, creating bespoke solutions and refactoring existing functionalities to optimize workflows. Successfully integrated the Odoo backend with Firebase to enable real-time data synchronization and seamless cross-platform communication.",
            "",
            "",
            "https://trackware.com",
            "trackwareOdoo.jpeg",
            Colors.white
        ),
      ],
    );
  }

  Widget _projectRow(bool leftText, String num, String title, String dec, String android, String ios, String web, String image, Color colorTit) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isMobile = constraints.maxWidth < 900;
      return Stack(
        clipBehavior: Clip.none,
        alignment: leftText ? Alignment.centerRight : Alignment.centerLeft,
        children: [
          Container(
            width: isMobile ? double.infinity : constraints.maxWidth * 0.7,
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withValues(alpha: 0.1),
                  blurRadius: 100,
                  spreadRadius: 10,
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.image, size: 50)),
              ),
            ),
          ),
          Positioned(
            left: leftText && !isMobile ? 0 : null,
            right: !leftText && !isMobile ? 0 : null,
            child: Column(
              crossAxisAlignment: leftText ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                const Text("Featured Project", style: TextStyle(color: Color(0xFFC084FC), fontSize: 14)),
                Text(title, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: colorTit)),
                const SizedBox(height: 20),
                Container(
                  width: isMobile ? constraints.maxWidth * 0.9 : 520,
                  padding: const EdgeInsets.all(35),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A2E).withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white10),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 20)
                    ],
                  ),
                  child: Text(
                    dec,
                    style: const TextStyle(color: Colors.grey, height: 1.6, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (android.isNotEmpty)
                        IconButton(
                          onPressed: () => _launchUrl(android),
                          icon:  Icon(Icons.android, color:colorTit , size: 22),
                        ),
                      if (ios.isNotEmpty)
                        IconButton(
                          onPressed: () => _launchUrl(ios),
                          icon:  Icon(Icons.apple, color: colorTit, size: 22),
                        ),
                      if (web.isNotEmpty)
                        IconButton(
                          onPressed: () => _launchUrl(web),
                          icon:  Icon(Icons.web, color: colorTit, size: 22),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Get In Touch",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 25),
        const Text(
          "I’m currently looking for new opportunities or interesting projects to collaborate on. Whether you have a question or just want to discuss Flutter, Odoo, or Backend architecture, my inbox is always open!",
          style: TextStyle(color: Colors.grey, fontSize: 17, height: 1.5),
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            _buildContactCard(
              icon: Icons.email_outlined,
              label: "yousef.ahmad.alfqeh@gmail.com",
              onTap: () async {
                final Uri uri = Uri(scheme: 'mailto', path: 'yousef.ahmad.alfqeh@gmail.com');
                if (await canLaunchUrl(uri)) await launchUrl(uri);
              },
            ),
            _buildContactCard(
              icon: Icons.chat_outlined,
              label: "WhatsApp Me",
              onTap: () async {
                final Uri uri = Uri.parse("https://wa.me/9627799807675");
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFC084FC).withValues(alpha: 0.5)),
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFC084FC).withValues(alpha: 0.05),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFFC084FC)),
            const SizedBox(width: 15),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC084FC),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
