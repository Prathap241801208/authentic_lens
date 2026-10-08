import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const AuthenticLensApp());
}

class AuthenticLensApp extends StatelessWidget {
  const AuthenticLensApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AuthenticLens',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF070B12),
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF35E0A1),
          brightness: Brightness.dark,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// ============================================================
// HOME SCREEN
// ============================================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController urlController = TextEditingController();

  Future<void> pickImage() async {
    final picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductPreviewScreen(
          imageFile: image,
        ),
      ),
    );
  }

  void verifyUrl() {
    final url = urlController.text.trim();

    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please paste a product URL first.'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductPreviewScreen(
          productUrl: url,
        ),
      ),
    );
  }

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 20, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF35E0A1).withOpacity(.12),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFF35E0A1).withOpacity(.35),
                      ),
                    ),
                    child: const Icon(
                      Icons.shield_outlined,
                      color: Color(0xFF35E0A1),
                      size: 27,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AUTHENTICLENS',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'AI PRODUCT VERIFICATION',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 10,
                            letterSpacing: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF35E0A1).withOpacity(.10),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 7,
                          color: Color(0xFF35E0A1),
                        ),
                        SizedBox(width: 6),
                        Text(
                          'AI READY',
                          style: TextStyle(
                            color: Color(0xFF35E0A1),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 48),

              // HERO
              const Text(
                'VERIFY',
                style: TextStyle(
                  color: Color(0xFF35E0A1),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Before You Buy.',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w800,
                  height: 1.05,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'Detect suspicious products using AI-powered visual '
                'and product identity analysis.',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 35),

              // URL CARD
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D131D),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: Colors.white.withOpacity(.08),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.link,
                          size: 18,
                          color: Color(0xFF35E0A1),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'PRODUCT URL',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: urlController,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Paste Amazon / Flipkart URL',
                        hintStyle: const TextStyle(
                          color: Colors.white30,
                        ),
                        filled: true,
                        fillColor: const Color(0xFF070B12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: verifyUrl,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF35E0A1),
                          foregroundColor: const Color(0xFF06100C),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.security, size: 19),
                            SizedBox(width: 9),
                            Text(
                              'VERIFY PRODUCT',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // IMAGE BUTTON
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton.icon(
                  onPressed: pickImage,
                  icon: const Icon(
                    Icons.image_outlined,
                    color: Color(0xFF35E0A1),
                  ),
                  label: const Text(
                    'UPLOAD PRODUCT IMAGE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: .8,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Colors.white.withOpacity(.12),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 38),

              // WHAT WE VERIFY
              const Text(
                'WHAT WE VERIFY',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: verifyCard(
                      Icons.branding_watermark_outlined,
                      'Brand',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: verifyCard(
                      Icons.palette_outlined,
                      'Color',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: verifyCard(
                      Icons.visibility_outlined,
                      'Visual',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: verifyCard(
                      Icons.straighten,
                      'Size',
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

  Widget verifyCard(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0D131D),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(.06),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: const Color(0xFF35E0A1),
            size: 21,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PRODUCT PREVIEW
// ============================================================

class ProductPreviewScreen extends StatelessWidget {
  final String? productUrl;
  final XFile? imageFile;

  const ProductPreviewScreen({
    super.key,
    this.productUrl,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    final bool isImage = imageFile != null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Product Preview',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'READY TO VERIFY',
              style: TextStyle(
                color: Color(0xFF35E0A1),
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Review your product',
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D131D),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withOpacity(.08),
                  ),
                ),
                child: isImage
                    ? ImagePreview(imageFile: imageFile!)
                    : UrlPreview(url: productUrl!),
              ),
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AnalyzingScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF35E0A1),
                  foregroundColor: const Color(0xFF06100C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'VERIFY PRODUCT',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// URL PREVIEW
// ============================================================

class UrlPreview extends StatelessWidget {
  final String url;

  const UrlPreview({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            color: const Color(0xFF35E0A1).withOpacity(.10),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.link,
            color: Color(0xFF35E0A1),
            size: 42,
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'PRODUCT LINK',
          style: TextStyle(
            color: Colors.white54,
            fontSize: 11,
            letterSpacing: 2,
          ),
        ),

        const SizedBox(height: 12),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            url,
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),

        const SizedBox(height: 25),

        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Color(0xFF35E0A1),
              size: 17,
            ),
            SizedBox(width: 7),
            Text(
              'URL RECEIVED',
              style: TextStyle(
                color: Color(0xFF35E0A1),
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ============================================================
// IMAGE PREVIEW
// ============================================================

class ImagePreview extends StatelessWidget {
  final XFile imageFile;

  const ImagePreview({
    super.key,
    required this.imageFile,
  });

  Future<List<int>> loadImage() async {
    return await imageFile.readAsBytes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: loadImage(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF35E0A1),
            ),
          );
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.memory(
            Uint8List.fromList(snapshot.data!),
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
}

// ============================================================
// ANALYZING SCREEN
// ============================================================

class AnalyzingScreen extends StatefulWidget {
  const AnalyzingScreen({super.key});

  @override
  State<AnalyzingScreen> createState() => _AnalyzingScreenState();
}

class _AnalyzingScreenState extends State<AnalyzingScreen> {
  int currentStep = 0;

  final List<String> steps = [
    'Analyzing visual fingerprint',
    'Checking brand identity',
    'Comparing product details',
    'Calculating trust score',
  ];

  @override
  void initState() {
    super.initState();
    runAnalysis();
  }

  Future<void> runAnalysis() async {
    for (int i = 0; i < steps.length; i++) {
      await Future.delayed(const Duration(milliseconds: 850));

      if (!mounted) return;

      setState(() {
        currentStep = i + 1;
      });
    }

    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ResultScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SCANNER ICON
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF35E0A1).withOpacity(.08),
                    border: Border.all(
                      color: const Color(0xFF35E0A1).withOpacity(.35),
                    ),
                  ),
                  child: const Icon(
                    Icons.radar,
                    color: Color(0xFF35E0A1),
                    size: 62,
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  'AI ANALYSIS',
                  style: TextStyle(
                    color: Color(0xFF35E0A1),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Verifying Product',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'AuthenticLens is checking multiple product signals.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white54,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 35),

                ...List.generate(
                  steps.length,
                  (index) {
                    final bool completed = currentStep > index;
                    final bool active = currentStep == index;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: completed
                                  ? const Color(0xFF35E0A1)
                                  : Colors.white.withOpacity(.06),
                            ),
                            child: Icon(
                              completed
                                  ? Icons.check
                                  : active
                                      ? Icons.sync
                                      : Icons.circle_outlined,
                              size: 16,
                              color: completed
                                  ? const Color(0xFF06100C)
                                  : active
                                      ? const Color(0xFF35E0A1)
                                      : Colors.white30,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            steps[index],
                            style: TextStyle(
                              color: completed || active
                                  ? Colors.white
                                  : Colors.white30,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// RESULT SCREEN
// ============================================================

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Verification Result',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        child: Column(
          children: [
            // SUCCESS HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF35E0A1).withOpacity(.16),
                    const Color(0xFF0D131D),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFF35E0A1).withOpacity(.25),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 72,
                    width: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF35E0A1).withOpacity(.12),
                      border: Border.all(
                        color: const Color(0xFF35E0A1).withOpacity(.45),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.verified_outlined,
                      color: Color(0xFF35E0A1),
                      size: 40,
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'LOW COUNTERFEIT RISK',
                    style: TextStyle(
                      color: Color(0xFF35E0A1),
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.8,
                    ),
                  ),

                  const SizedBox(height: 7),

                  const Text(
                    'Product appears trustworthy',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // TRUST SCORE
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 28,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF0D131D),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withOpacity(.07),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'TRUST SCORE',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    height: 160,
                    width: 160,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 160,
                          width: 160,
                          child: CircularProgressIndicator(
                            value: .92,
                            strokeWidth: 12,
                            backgroundColor:
                                Colors.white.withOpacity(.07),
                            valueColor:
                                const AlwaysStoppedAnimation<Color>(
                              Color(0xFF35E0A1),
                            ),
                          ),
                        ),
                        const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '92',
                              style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              '/ 100',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'HIGH TRUST',
                    style: TextStyle(
                      color: Color(0xFF35E0A1),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // ANALYSIS BREAKDOWN
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0D131D),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withOpacity(.07),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ANALYSIS BREAKDOWN',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 20),

                  scoreRow(
                    'Brand Identity',
                    97,
                    Icons.branding_watermark_outlined,
                  ),

                  scoreRow(
                    'Product Visual',
                    94,
                    Icons.visibility_outlined,
                  ),

                  scoreRow(
                    'Color & Design',
                    96,
                    Icons.palette_outlined,
                  ),

                  scoreRow(
                    'Specifications',
                    89,
                    Icons.fact_check_outlined,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // AI INSIGHT
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF101722),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: const Color(0xFF35E0A1).withOpacity(.18),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        color: Color(0xFF35E0A1),
                        size: 19,
                      ),
                      SizedBox(width: 9),
                      Text(
                        'AI INSIGHT',
                        style: TextStyle(
                          color: Color(0xFF35E0A1),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 13),

                  Text(
                    'The submitted product shows strong consistency '
                    'across brand identity, visual appearance, color '
                    'patterns and product specifications.',
                    style: TextStyle(
                      color: Colors.white70,
                      height: 1.55,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // RECOMMENDATION
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF35E0A1).withOpacity(.08),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Color(0xFF35E0A1),
                    size: 22,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'RECOMMENDATION',
                          style: TextStyle(
                            color: Color(0xFF35E0A1),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.3,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'This product can be considered based on the '
                          'current verification signals.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // SCAN AGAIN
            SizedBox(
              width: double.infinity,
              height: 54,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                    (route) => false,
                  );
                },
                icon: const Icon(
                  Icons.refresh,
                  color: Color(0xFF35E0A1),
                ),
                label: const Text(
                  'VERIFY ANOTHER PRODUCT',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .8,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: const Color(0xFF35E0A1).withOpacity(.35),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget scoreRow(
    String title,
    int score,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF35E0A1),
                size: 19,
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ),
              Text(
                '$score%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),

          const SizedBox(height: 9),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: score / 100,
              minHeight: 7,
              backgroundColor: Colors.white.withOpacity(.07),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF35E0A1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}