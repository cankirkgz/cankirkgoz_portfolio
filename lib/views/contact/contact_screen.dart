import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';
import 'package:my_portfolio/design/atoms/rounded_button.dart';
import 'package:my_portfolio/design/molecules/custom_text_field.dart';
import 'package:my_portfolio/design/molecules/social_card.dart';
import 'package:my_portfolio/design/molecules/schedule_card.dart';

/// ContactScreen with staggered entrance animations for each section.
class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  late final AnimationController _controller;
  final List<Animation<double>> _fadeAnims = [];
  final List<Animation<Offset>> _slideAnims = [];
  final int _sectionCount =
      7; // header text, subtitle, form container, success, social, schedule, padding

  bool _isSubmitting = false;
  bool _showSuccess = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();

    // Create staggered animations for each section
    for (int i = 0; i < _sectionCount; i++) {
      double start = i / _sectionCount;
      double end = (i + 1) / _sectionCount;
      _fadeAnims.add(
        Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(start, end, curve: Curves.easeIn),
          ),
        ),
      );
      _slideAnims.add(
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(start, end, curve: Curves.easeOut),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isSubmitting = true;
      _showSuccess = false;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isSubmitting = false;
      _showSuccess = true;
    });
    _formKey.currentState!.reset();
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) setState(() => _showSuccess = false);
    });
  }

  Widget _buildAnimated(int index, Widget child) {
    return FadeTransition(
      opacity: _fadeAnims[index],
      child: SlideTransition(
        position: _slideAnims[index],
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white, // Tek renk arka plan
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 0: Header title
              _buildAnimated(
                0,
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Benimle ",
                        style: TextStyle(
                          fontSize: AppSizes.fontXXXXL,
                          fontWeight: AppSizes.fontWeightBold,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [AppColors.blueText, AppColors.purpleText],
                        ).createShader(bounds),
                        blendMode: BlendMode.srcIn,
                        child: Text(
                          'İletişime Geç',
                          style: TextStyle(
                            fontSize: AppSizes.fontXXXXL,
                            fontWeight: AppSizes.fontWeightBold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // 1: Subtitle
              _buildAnimated(
                1,
                Center(
                  child: Text(
                    "Bir sorunuz varsa, sadece selam vermek istiyorsanız ya da bir proje hakkında konuşmak istiyorsanız, bana ulaşmaktan çekinmeyin. Mesajınızı duymaktan mutluluk duyarım!",
                    style: TextStyle(
                      fontSize: AppSizes.fontL,
                      color: AppColors.textPrimary.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 800;
                  return Flex(
                    direction: isWide ? Axis.horizontal : Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 2: Contact form card
                      Expanded(
                        flex: isWide ? 1 : 0,
                        child: _buildAnimated(
                          2,
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bana bir mesaj gönderin',
                                  style: TextStyle(
                                    fontSize: AppSizes.fontXXL,
                                    fontWeight: AppSizes.fontWeightSemiBold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Genellikle 24–48 saat içinde yanıt veririm.',
                                  style: TextStyle(
                                    fontSize: AppSizes.fontM,
                                    color:
                                        AppColors.textPrimary.withOpacity(0.6),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      CustomTextField(
                                        controller: _nameController,
                                        label: 'İsim Soyisim',
                                        validator: (v) =>
                                            v!.isEmpty ? 'Gerekli' : null,
                                      ),
                                      const SizedBox(height: 20),
                                      CustomTextField(
                                        controller: _emailController,
                                        label: 'Email',
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (v) {
                                          if (v!.isEmpty) return 'Gerekli';
                                          final regex = RegExp(
                                              r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
                                          return regex.hasMatch(v)
                                              ? null
                                              : 'Invalid email';
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      CustomTextField(
                                        controller: _messageController,
                                        label: 'Mesajın',
                                        maxLines: 5,
                                        validator: (v) =>
                                            v!.isEmpty ? 'Gerekli' : null,
                                      ),
                                      const SizedBox(height: 24),
                                      RoundedButton(
                                        firstText: 'Mesaj Gönder',
                                        icon: 'assets/icons/postman_icon.png',
                                        type: ButtonType.gradient,
                                        onPressed:
                                            _isSubmitting ? () {} : _submitForm,
                                        width: double.infinity,
                                        height: AppSizes.buttonHeightL,
                                        hasShadow: true,
                                      ),
                                      const SizedBox(height: 16),
                                      // 3: Success banner
                                      AnimatedOpacity(
                                        opacity: _showSuccess ? 1 : 0,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade50,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            border: Border.all(
                                                color: Colors.green.shade200),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 32,
                                                height: 32,
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Mesajın başarıyla gönderildi!',
                                                    style: TextStyle(
                                                      color:
                                                          Colors.green.shade800,
                                                      fontWeight: AppSizes
                                                          .fontWeightMedium,
                                                    ),
                                                  ),
                                                  Text(
                                                    "En yakın zamanda sana döneceğim.",
                                                    style: TextStyle(
                                                      color:
                                                          Colors.green.shade600,
                                                      fontSize: AppSizes.fontS,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (isWide)
                        const SizedBox(width: 40)
                      else
                        const SizedBox(height: 40),
                      // 4: Social card
                      Expanded(
                        flex: isWide ? 1 : 0,
                        child: Column(
                          children: [
                            _buildAnimated(4, const SocialCard()),
                            const SizedBox(height: 24),
                            // 5: Schedule card
                            _buildAnimated(5, const ScheduleCard()),
                          ],
                        ),
                      ),
                      // 6: bottom padding
                      const SizedBox(height: 80),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
