import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'summary_screen.dart';

class OnboardingQuizScreen extends StatefulWidget {
  final String language;
  final bool isRTL;

  const OnboardingQuizScreen({
    super.key,
    required this.language,
    required this.isRTL,
  });

  @override
  State<OnboardingQuizScreen> createState() => _OnboardingQuizScreenState();
}

class _OnboardingQuizScreenState extends State<OnboardingQuizScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 11;

  // Store answers
  String? _age;
  String _location = '';
  String? _timePreference;
  String? _improvementArea;
  String? _selectedPath;
  String? _motivationSource;
  double _busyLevel = 5;
  double _organizationLevel = 3;
  double _frustrationLevel = 3;
  String? _commitmentFactor;
  bool _wantsFriend = false;
  String _friendInfo = '';

  final _locationController = TextEditingController();
  final _friendController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _locationController.dispose();
    _friendController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _saveAnswersAndNavigate();
    }
  }

  Future<void> _saveAnswersAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('age', _age ?? '');
    await prefs.setString('location', _location);
    await prefs.setString('timePreference', _timePreference ?? '');
    await prefs.setString('improvementArea', _improvementArea ?? '');
    await prefs.setString('selectedPath', _selectedPath ?? '');
    await prefs.setString('motivationSource', _motivationSource ?? '');
    await prefs.setDouble('busyLevel', _busyLevel);
    await prefs.setDouble('organizationLevel', _organizationLevel);
    await prefs.setDouble('frustrationLevel', _frustrationLevel);
    await prefs.setString('commitmentFactor', _commitmentFactor ?? '');
    await prefs.setBool('wantsFriend', _wantsFriend);
    await prefs.setString('friendInfo', _friendInfo);

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SummaryScreen(
          age: _age ?? '',
          location: _location,
          timePreference: _timePreference ?? '',
          improvementArea: _improvementArea ?? '',
          selectedPath: _selectedPath ?? '',
          motivationSource: _motivationSource ?? '',
          busyLevel: _busyLevel,
          organizationLevel: _organizationLevel,
          frustrationLevel: _frustrationLevel,
          commitmentFactor: _commitmentFactor ?? '',
          wantsFriend: _wantsFriend,
          friendInfo: _friendInfo,
          language: widget.language,
          isRTL: widget.isRTL,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F0),
      body: SafeArea(
        child: Column(
          children: [
            // Progress bar
            _buildProgressBar(),
            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildQuestion1(), // Age
                  _buildQuestion2(), // Location
                  _buildQuestion3(), // Morning/Evening person
                  _buildQuestion4(), // Improvement area
                  _buildQuestion5(), // Path selection
                  _buildQuestion6(), // Pride/Achievement
                  _buildQuestion7(), // Busy level slider
                  _buildQuestion8(), // Organization level
                  _buildQuestion9(), // Frustration level
                  _buildQuestion10(), // Commitment factor
                  _buildQuestion11(), // Friend challenge
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_currentPage + 1}/$_totalPages',
                style: GoogleFonts.cairo(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              Text(
                'استبيان التعرف',
                style: GoogleFonts.cairo(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: (_currentPage + 1) / _totalPages,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF4A90E2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Question 1: Age
  Widget _buildQuestion1() {
    return _buildQuestionTemplate(
      question: 'كم عمرك؟',
      child: Column(
        children: [
          _buildOptionButton('18-24', _age == '18-24', () {
            setState(() => _age = '18-24');
            _nextPage();
          }),
          _buildOptionButton('25-34', _age == '25-34', () {
            setState(() => _age = '25-34');
            _nextPage();
          }),
          _buildOptionButton('35-44', _age == '35-44', () {
            setState(() => _age = '35-44');
            _nextPage();
          }),
          _buildOptionButton('45-54', _age == '45-54', () {
            setState(() => _age = '45-54');
            _nextPage();
          }),
          _buildOptionButton('55+', _age == '55+', () {
            setState(() => _age = '55+');
            _nextPage();
          }),
        ],
      ),
    );
  }

  // Question 2: Location
  Widget _buildQuestion2() {
    return _buildQuestionTemplate(
      question: 'أين تعيش؟ (مدينة أو بلد)',
      child: Column(
        children: [
          TextField(
            controller: _locationController,
            style: GoogleFonts.cairo(fontSize: 16),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'أدخل المدينة أو البلد',
              hintStyle: GoogleFonts.cairo(color: Colors.black38),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFF4A90E2),
                  width: 2,
                ),
              ),
            ),
            onChanged: (value) {
              setState(() => _location = value);
            },
          ),
          const SizedBox(height: 24),
          _buildContinueButton(enabled: _location.isNotEmpty),
        ],
      ),
    );
  }

  // Question 3: Morning/Evening person
  Widget _buildQuestion3() {
    return _buildQuestionTemplate(
      question: 'هل أنت كائن صباحي أم مسائي؟',
      child: Column(
        children: [
          _buildOptionButton('صباحي 🌅', _timePreference == 'صباحي', () {
            setState(() => _timePreference = 'صباحي');
            _nextPage();
          }),
          _buildOptionButton('مسائي 🌙', _timePreference == 'مسائي', () {
            setState(() => _timePreference = 'مسائي');
            _nextPage();
          }),
          _buildOptionButton('متوسط', _timePreference == 'متوسط', () {
            setState(() => _timePreference = 'متوسط');
            _nextPage();
          }),
        ],
      ),
    );
  }

  // Question 4: Improvement area
  Widget _buildQuestion4() {
    return _buildQuestionTemplate(
      question: 'إذا كان بإمكانك تحسين جانب واحد في حياتك غداً، ماذا سيكون؟',
      child: Column(
        children: [
          _buildOptionButton('صحتي', _improvementArea == 'صحتي', () {
            setState(() => _improvementArea = 'صحتي');
            _nextPage();
          }),
          _buildOptionButton('تركيزي', _improvementArea == 'تركيزي', () {
            setState(() => _improvementArea = 'تركيزي');
            _nextPage();
          }),
          _buildOptionButton('إنتاجيتي', _improvementArea == 'إنتاجيتي', () {
            setState(() => _improvementArea = 'إنتاجيتي');
            _nextPage();
          }),
          _buildOptionButton('نومي', _improvementArea == 'نومي', () {
            setState(() => _improvementArea = 'نومي');
            _nextPage();
          }),
          _buildOptionButton('علاقاتي', _improvementArea == 'علاقاتي', () {
            setState(() => _improvementArea = 'علاقاتي');
            _nextPage();
          }),
          _buildOptionButton('أخرى', _improvementArea == 'أخرى', () {
            setState(() => _improvementArea = 'أخرى');
            _nextPage();
          }),
        ],
      ),
    );
  }

  // Question 5: Path selection (with beautiful cards)
  Widget _buildQuestion5() {
    return _buildQuestionTemplate(
      question: 'أي مسار تحب تبدأ فيه أولاً؟',
      child: Column(
        children: [
          _buildPathCard(
            title: 'المسار الجسدي',
            emoji: '🏃',
            description: 'حركة، ماء، نوم',
            color: const Color(0xFF50C878),
            isSelected: _selectedPath == 'المسار الجسدي',
            onTap: () {
              setState(() => _selectedPath = 'المسار الجسدي');
              _nextPage();
            },
          ),
          const SizedBox(height: 16),
          _buildPathCard(
            title: 'المسار الذهني',
            emoji: '🧠',
            description: 'قراءة، تأمل، تعلم',
            color: const Color(0xFF4A90E2),
            isSelected: _selectedPath == 'المسار الذهني',
            onTap: () {
              setState(() => _selectedPath = 'المسار الذهني');
              _nextPage();
            },
          ),
          const SizedBox(height: 16),
          _buildPathCard(
            title: 'المسار الإنتاجي',
            emoji: '📈',
            description: 'ترتيب الوقت، إنجاز المهام',
            color: const Color(0xFFFF6B6B),
            isSelected: _selectedPath == 'المسار الإنتاجي',
            onTap: () {
              setState(() => _selectedPath = 'المسار الإنتاجي');
              _nextPage();
            },
          ),
        ],
      ),
    );
  }

  // Question 6: Pride/Achievement
  Widget _buildQuestion6() {
    return _buildQuestionTemplate(
      question: 'شو أكثر شي بخليك تحس بالفخر أو الإنجاز؟',
      child: Column(
        children: [
          _buildOptionButton(
            'رؤية نتائج بالأرقام',
            _motivationSource == 'أرقام',
            () {
              setState(() => _motivationSource = 'أرقام');
              _nextPage();
            },
          ),
          _buildOptionButton(
            'كلمة تشجيع من صديق',
            _motivationSource == 'تشجيع',
            () {
              setState(() => _motivationSource = 'تشجيع');
              _nextPage();
            },
          ),
          _buildOptionButton('إنجاز شخصي', _motivationSource == 'إنجاز', () {
            setState(() => _motivationSource = 'إنجاز');
            _nextPage();
          }),
          _buildOptionButton('كسر روتين ممل', _motivationSource == 'روتين', () {
            setState(() => _motivationSource = 'روتين');
            _nextPage();
          }),
          _buildOptionButton('أخرى', _motivationSource == 'أخرى', () {
            setState(() => _motivationSource = 'أخرى');
            _nextPage();
          }),
        ],
      ),
    );
  }

  // Question 7: Busy level slider
  Widget _buildQuestion7() {
    return _buildQuestionTemplate(
      question: 'قديش يومك مشغول من 1 إلى 10؟',
      child: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            _busyLevel.round().toString(),
            style: GoogleFonts.cairo(
              fontSize: 72,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4A90E2),
            ),
          ),
          const SizedBox(height: 40),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: const Color(0xFF4A90E2),
              inactiveTrackColor: Colors.grey.shade200,
              thumbColor: const Color(0xFF4A90E2),
              overlayColor: const Color(0xFF4A90E2).withOpacity(0.2),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 16),
              trackHeight: 8,
            ),
            child: Slider(
              value: _busyLevel,
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (value) {
                setState(() => _busyLevel = value);
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('10', style: GoogleFonts.cairo(color: Colors.black54)),
              Text('1', style: GoogleFonts.cairo(color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 40),
          _buildContinueButton(enabled: true),
        ],
      ),
    );
  }

  // Question 8: Organization level
  Widget _buildQuestion8() {
    return _buildQuestionTemplate(
      question: 'هل أنت منظم وتلتزم بالخطط بسهولة؟',
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildScaleButtons(
            selectedValue: _organizationLevel,
            onChanged: (value) {
              setState(() => _organizationLevel = value);
              _nextPage();
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'دائماً',
                style: GoogleFonts.cairo(color: Colors.black54, fontSize: 12),
              ),
              Text(
                'لا أبداً',
                style: GoogleFonts.cairo(color: Colors.black54, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Question 9: Frustration level
  Widget _buildQuestion9() {
    return _buildQuestionTemplate(
      question: 'هل تتأثر بسهولة بالإحباط لو فشلت في يوم واحد؟',
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildScaleButtons(
            selectedValue: _frustrationLevel,
            onChanged: (value) {
              setState(() => _frustrationLevel = value);
              _nextPage();
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'دائماً',
                style: GoogleFonts.cairo(color: Colors.black54, fontSize: 12),
              ),
              Text(
                'لا أبداً',
                style: GoogleFonts.cairo(color: Colors.black54, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Question 10: Commitment factor
  Widget _buildQuestion10() {
    return _buildQuestionTemplate(
      question: 'ما الذي يجعلك تلتزم بعادة جديدة عادةً؟',
      child: Column(
        children: [
          _buildOptionButton(
            'كلمة من صديق أو شخص يراقبني',
            _commitmentFactor == 'صديق',
            () {
              setState(() => _commitmentFactor = 'صديق');
              _nextPage();
            },
          ),
          _buildOptionButton(
            'رؤية نتائج وبيانات علمية',
            _commitmentFactor == 'بيانات',
            () {
              setState(() => _commitmentFactor = 'بيانات');
              _nextPage();
            },
          ),
          _buildOptionButton(
            'شعوري بالإنجاز الشخصي فقط',
            _commitmentFactor == 'إنجاز',
            () {
              setState(() => _commitmentFactor = 'إنجاز');
              _nextPage();
            },
          ),
          _buildOptionButton(
            'الحرية وكسر الروتين',
            _commitmentFactor == 'حرية',
            () {
              setState(() => _commitmentFactor = 'حرية');
              _nextPage();
            },
          ),
        ],
      ),
    );
  }

  // Question 11: Friend challenge
  Widget _buildQuestion11() {
    return _buildQuestionTemplate(
      question: 'هل تحب تضيف صديق أو شريك للتحدي معك؟ (اختياري)',
      child: Column(
        children: [
          _buildOptionButton('نعم', _wantsFriend, () {
            setState(() => _wantsFriend = true);
          }),
          const SizedBox(height: 16),
          if (_wantsFriend) ...[
            TextField(
              controller: _friendController,
              style: GoogleFonts.cairo(fontSize: 16),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'أدخل البريد الإلكتروني أو الاسم',
                hintStyle: GoogleFonts.cairo(color: Colors.black38),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color(0xFF4A90E2),
                    width: 2,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() => _friendInfo = value);
              },
            ),
            const SizedBox(height: 16),
          ],
          _buildOptionButton('لا، أفضل البدء بمفردي', !_wantsFriend, () {
            setState(() => _wantsFriend = false);
          }),
          const SizedBox(height: 32),
          _buildContinueButton(enabled: true),
        ],
      ),
    );
  }

  // Helper widgets
  Widget _buildQuestionTemplate({
    required String question,
    required Widget child,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Text(
            question,
            style: GoogleFonts.cairo(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          child,
        ],
      ),
    );
  }

  Widget _buildOptionButton(String text, bool isSelected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: isSelected
            ? const Color(0xFF4A90E2).withOpacity(0.1)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF4A90E2)
                    : Colors.grey.shade200,
                width: isSelected ? 2 : 1.5,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                      color: isSelected
                          ? const Color(0xFF4A90E2)
                          : Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF4A90E2),
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPathCard({
    required String title,
    required String emoji,
    required String description,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: isSelected ? 8 : 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? color : Colors.transparent,
              width: 3,
            ),
            gradient: isSelected
                ? LinearGradient(
                    colors: [color.withOpacity(0.1), Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(emoji, style: const TextStyle(fontSize: 32)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.cairo(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: GoogleFonts.cairo(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected) Icon(Icons.check_circle, color: color, size: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScaleButtons({
    required double selectedValue,
    required Function(double) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (index) {
        final value = (index + 1).toDouble();
        final isSelected = selectedValue == value;
        return GestureDetector(
          onTap: () => onChanged(value),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF4A90E2) : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF4A90E2)
                    : Colors.grey.shade300,
                width: 2,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: const Color(0xFF4A90E2).withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                value.round().toString(),
                style: GoogleFonts.cairo(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildContinueButton({required bool enabled}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled ? _nextPage : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4A90E2),
          disabledBackgroundColor: Colors.grey.shade300,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: enabled ? 4 : 0,
        ),
        child: Text(
          'متابعة',
          style: GoogleFonts.cairo(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: enabled ? Colors.white : Colors.grey.shade500,
          ),
        ),
      ),
    );
  }
}
