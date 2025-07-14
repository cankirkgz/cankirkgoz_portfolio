import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_portfolio/core/constants/app_colors.dart';
import 'package:my_portfolio/core/constants/app_sizes.dart';
import 'package:my_portfolio/design/atoms/rounded_button.dart';
import 'package:my_portfolio/design/molecules/custom_text_field.dart';
import 'package:my_portfolio/design/molecules/social_card.dart';
import 'package:my_portfolio/design/molecules/schedule_card.dart';
import 'package:my_portfolio/l10n/app_localizations.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  bool _isSubmitting = false;

  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final uri = Uri.parse('https://getform.io/f/bejlenya');
      final response = await http.post(uri, body: {
        'name': nameController.text,
        'email': emailController.text,
        'message': messageController.text,
      });

      if (response.statusCode == 200 || response.statusCode == 302) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.messageSent)),
          );
        }
        nameController.clear();
        emailController.clear();
        messageController.clear();
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(AppLocalizations.of(context)!.errorOccurred)),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.errorOccurred)),
        );
      }
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: nameController,
            label: AppLocalizations.of(context)!.name,
            validator: (v) =>
                v!.isEmpty ? AppLocalizations.of(context)!.required : null,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: emailController,
            label: AppLocalizations.of(context)!.email,
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v!.isEmpty) return AppLocalizations.of(context)!.required;
              final regex = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");
              return regex.hasMatch(v)
                  ? null
                  : AppLocalizations.of(context)!.invalidEmail;
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: messageController,
            label: AppLocalizations.of(context)!.message,
            maxLines: 5,
            validator: (v) =>
                v!.isEmpty ? AppLocalizations.of(context)!.required : null,
          ),
          const SizedBox(height: 24),
          RoundedButton(
            firstText: AppLocalizations.of(context)!.sendMessage,
            icon: 'assets/icons/postman_icon.png',
            type: ButtonType.gradient,
            onPressed: _isSubmitting ? () {} : submitForm,
            width: double.infinity,
            height: AppSizes.buttonHeightL,
            hasShadow: true,
          ),
        ],
      ),
    );
  }
}

/// ContactScreen with staggered entrance animations for each section.
class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<Animation<double>> _fadeAnims = [];
  final List<Animation<Offset>> _slideAnims = [];
  final int _sectionCount =
      5; // header text, subtitle, form container, social, schedule

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
    super.dispose();
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
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground(context),
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
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [AppColors.blueText, AppColors.purpleText],
                    ).createShader(bounds),
                    blendMode: BlendMode.srcIn,
                    child: Text.rich(
                      TextSpan(
                        text: AppLocalizations.of(context)!.getInTouch,
                        style: TextStyle(
                          fontSize: AppSizes.fontXXXXL,
                          fontWeight: AppSizes.fontWeightBold,
                          color: AppColors.textPrimary(context),
                        ),
                      ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // 1: Subtitle
              _buildAnimated(
                1,
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.contactSubtitle,
                    style: TextStyle(
                      fontSize: AppSizes.fontL,
                      color: AppColors.textPrimary(context).withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Inside LayoutBuilder in ContactScreen.build:
              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final isWide = width > 1000;
                  final isTablet = width > 600 && width <= 1000;
                  final isMobile = width <= 600;

                  final double spacing = isWide ? 40 : 24;
                  final double formPadding = isMobile ? 20 : 32;
                  final double titleFontSize = isMobile
                      ? AppSizes.fontXXL
                      : (isTablet ? AppSizes.fontXXXL : AppSizes.fontXXXXL);

                  return Flex(
                    direction: isWide ? Axis.horizontal : Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Contact form
                      Expanded(
                        flex: isWide ? 1 : 0,
                        child: _buildAnimated(
                          2,
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.card(context),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.shadow(context)
                                      .withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              border:
                                  Border.all(color: AppColors.border(context)),
                            ),
                            padding: EdgeInsets.all(formPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.sendMeMessage,
                                  style: TextStyle(
                                    fontSize: titleFontSize,
                                    fontWeight: AppSizes.fontWeightSemiBold,
                                    color: AppColors.textPrimary(context),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  AppLocalizations.of(context)!.responseTime,
                                  style: TextStyle(
                                    fontSize: AppSizes.fontM,
                                    color: AppColors.textPrimary(context)
                                        .withOpacity(0.6),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                const ContactForm(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: isWide ? 0 : spacing,
                          width: isWide ? spacing : 0),
                      // Social + Schedule
                      Expanded(
                        flex: isWide ? 1 : 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildAnimated(3, const SocialCard()),
                            const SizedBox(height: 24),
                            _buildAnimated(4, const ScheduleCard()),
                          ],
                        ),
                      ),
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
