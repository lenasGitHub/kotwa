import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboarding_quiz_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _showEmailForm = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _navigateToQuiz() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            const OnboardingQuizScreen(language: '', isRTL: false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9F0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 60),
                // App Logo
                _buildLogo(),
                const SizedBox(height: 40),
                // Title
                Text(
                  'ابدأ رحلتك نحو حياة أفضل',
                  style: GoogleFonts.cairo(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                // Subtitle
                Text(
                  'سجل الآن وخلينا نساعدك تبني عادات إيجابية في 7 أيام فقط',
                  style: GoogleFonts.cairo(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // Sign-up options or form
                if (!_showEmailForm) ...[
                  _buildSignUpButtons(),
                ] else ...[
                  _buildEmailForm(),
                ],
                const SizedBox(height: 24),
                // Login link
                if (!_showEmailForm)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'لديك حساب بالفعل؟ ',
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to login screen
                          _showLoginDialog();
                        },
                        child: Text(
                          'تسجيل الدخول',
                          style: GoogleFonts.cairo(
                            fontSize: 14,
                            color: const Color(0xFF4A90E2),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                // Skip button
                if (!_showEmailForm)
                  TextButton(
                    onPressed: _navigateToQuiz,
                    child: Text(
                      'تخطي التسجيل والبدء كضيف',
                      style: GoogleFonts.cairo(
                        fontSize: 14,
                        color: Colors.black45,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                if (!_showEmailForm)
                  Text(
                    '(بعض الميزات مثل تحديات الأصدقاء تتطلب التسجيل)',
                    style: GoogleFonts.cairo(
                      fontSize: 12,
                      color: Colors.black38,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 120,
      height: 120,
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
      child: const Icon(Icons.check, size: 60, color: Colors.white),
    );
  }

  Widget _buildSignUpButtons() {
    return Column(
      children: [
        // Email signup button
        _buildButton(
          text: 'التسجيل بالبريد الإلكتروني',
          icon: Icons.email_outlined,
          color: const Color(0xFF4A90E2),
          onTap: () {
            setState(() {
              _showEmailForm = true;
            });
          },
        ),
        const SizedBox(height: 16),
        // Google signup button
        _buildButton(
          text: 'المتابعة بـ Google',
          icon: Icons.g_mobiledata,
          color: Colors.white,
          textColor: Colors.black87,
          borderColor: Colors.grey.shade300,
          onTap: () {
            // Handle Google sign-in
            _navigateToQuiz();
          },
        ),
        const SizedBox(height: 16),
        // Apple signup button
        _buildButton(
          text: 'المتابعة بـ Apple',
          icon: Icons.apple,
          color: Colors.black,
          onTap: () {
            // Handle Apple sign-in
            _navigateToQuiz();
          },
        ),
      ],
    );
  }

  Widget _buildButton({
    required String text,
    required IconData icon,
    required Color color,
    Color? textColor,
    Color? borderColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(16),
      elevation: borderColor == null ? 2 : 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: borderColor != null
                ? Border.all(color: borderColor, width: 1.5)
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor ?? Colors.white, size: 24),
              const SizedBox(width: 12),
              Text(
                text,
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textColor ?? Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Back button
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                setState(() {
                  _showEmailForm = false;
                });
              },
            ),
          ),
          const SizedBox(height: 16),
          // Full name field
          _buildTextField(
            controller: _nameController,
            label: 'الاسم الكامل',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 16),
          // Email field
          _buildTextField(
            controller: _emailController,
            label: 'البريد الإلكتروني',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          // Password field
          _buildTextField(
            controller: _passwordController,
            label: 'كلمة المرور',
            icon: Icons.lock_outline,
            isPassword: true,
          ),
          const SizedBox(height: 16),
          // Confirm password field
          _buildTextField(
            controller: _confirmPasswordController,
            label: 'تأكيد كلمة المرور',
            icon: Icons.lock_outline,
            isPassword: true,
          ),
          const SizedBox(height: 32),
          // Submit button
          _buildButton(
            text: 'إنشاء حساب',
            icon: Icons.check,
            color: const Color(0xFF4A90E2),
            onTap: () {
              if (_formKey.currentState!.validate()) {
                _navigateToQuiz();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      style: GoogleFonts.cairo(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.cairo(color: Colors.black54),
        prefixIcon: Icon(icon, color: const Color(0xFF4A90E2)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF4A90E2), width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        return null;
      },
    );
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'تسجيل الدخول',
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'صفحة تسجيل الدخول قيد التطوير',
          style: GoogleFonts.cairo(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'حسناً',
              style: GoogleFonts.cairo(color: const Color(0xFF4A90E2)),
            ),
          ),
        ],
      ),
    );
  }
}
