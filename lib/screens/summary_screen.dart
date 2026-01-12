import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker_challenge/features/home/presentation/screens/home_screen.dart';

class SummaryScreen extends StatelessWidget {
  final String age;
  final String location;
  final String timePreference;
  final String improvementArea;
  final String selectedPath;
  final String motivationSource;
  final double busyLevel;
  final double organizationLevel;
  final double frustrationLevel;
  final String commitmentFactor;
  final bool wantsFriend;
  final String friendInfo;
  final String language;
  final bool isRTL;

  const SummaryScreen({
    super.key,
    required this.age,
    required this.location,
    required this.timePreference,
    required this.improvementArea,
    required this.selectedPath,
    required this.motivationSource,
    required this.busyLevel,
    required this.organizationLevel,
    required this.frustrationLevel,
    required this.commitmentFactor,
    required this.wantsFriend,
    required this.friendInfo,
    required this.language,
    required this.isRTL,
  });

  String _getPersonalizedSummary() {
    String summary = 'بناءً على إجاباتك، ';

    // Time preference
    if (timePreference == 'صباحي') {
      summary += 'أنت كائن صباحي نشيط، ';
    } else if (timePreference == 'مسائي') {
      summary += 'أنت كائن مسائي مبدع، ';
    } else {
      summary += 'أنت شخص متوازن، ';
    }

    // Busy level
    if (busyLevel >= 7) {
      summary += 'يومك مشغول جداً (${busyLevel.round()}/10)، ';
    } else if (busyLevel >= 4) {
      summary += 'يومك مشغول بدرجة متوسطة (${busyLevel.round()}/10)، ';
    } else {
      summary += 'لديك وقت جيد في يومك (${busyLevel.round()}/10)، ';
    }

    // Commitment factor
    if (commitmentFactor == 'صديق') {
      summary += 'وتحتاج تشجيع خارجي للالتزام. ';
    } else if (commitmentFactor == 'بيانات') {
      summary += 'وتحتاج رؤية بيانات ونتائج للالتزام. ';
    } else if (commitmentFactor == 'إنجاز') {
      summary += 'وتعتمد على شعورك الشخصي بالإنجاز. ';
    } else {
      summary += 'وتحب الحرية وكسر الروتين. ';
    }

    // Improvement area
    summary += '\n\nتريد تحسين $improvementArea، ';

    // Selected path
    summary += 'واخترت البدء في $selectedPath.';

    return summary;
  }

  String _getSuggestedChallenge() {
    if (selectedPath.contains('الجسدي')) {
      return 'تحدي شرب 8 أكواب ماء يومياً لمدة 7 أيام 💧';
    } else if (selectedPath.contains('الذهني')) {
      return 'تحدي القراءة لمدة 15 دقيقة يومياً لمدة 7 أيام 📚';
    } else {
      return 'تحدي إنجاز 3 مهام رئيسية يومياً لمدة 7 أيام ✅';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              // Success icon
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFF50C878),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF50C878).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.celebration,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Title
              Text(
                'رائع! تعرفنا عليك 🎉',
                style: GoogleFonts.cairo(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // Summary card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Color(0xFF4A90E2),
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'ملخصك الشخصي',
                          style: GoogleFonts.cairo(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _getPersonalizedSummary(),
                      style: GoogleFonts.cairo(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.8,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Suggested challenge card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4A90E2), Color(0xFF50C878)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4A90E2).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.emoji_events,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'تحديك الأول',
                          style: GoogleFonts.cairo(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _getSuggestedChallenge(),
                      style: GoogleFonts.cairo(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Additional info if friend was added
              if (wantsFriend && friendInfo.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A90E2).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF4A90E2).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.people,
                        color: Color(0xFF4A90E2),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'سنرسل دعوة لصديقك: $friendInfo',
                          style: GoogleFonts.cairo(
                            fontSize: 14,
                            color: const Color(0xFF4A90E2),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (wantsFriend && friendInfo.isNotEmpty)
                const SizedBox(height: 24),
              // Start challenge button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to home screen
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                            HomeScreen(language: language, isRTL: isRTL),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF50C878),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ابدأ التحدي الآن!',
                        style: GoogleFonts.cairo(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.rocket_launch,
                        color: Colors.white,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
