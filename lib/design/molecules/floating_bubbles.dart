import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';

class FloatingBubbles extends StatefulWidget {
  const FloatingBubbles({super.key});

  @override
  State<FloatingBubbles> createState() => _FloatingBubblesState();
}

class _FloatingBubblesState extends State<FloatingBubbles>
    with TickerProviderStateMixin {
  late final AnimationController _controller1;
  late final AnimationController _controller2;
  late final AnimationController _controller3;

  @override
  void initState() {
    super.initState();

    _controller1 = _createController(duration: 1000);
    _controller2 = _createController(duration: 1500);
    _controller3 = _createController(duration: 1800);
  }

  AnimationController _createController({required int duration}) {
    final controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: duration),
    )..repeat(reverse: true);
    return controller;
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildAnimatedBubble(
          controller: _controller1,
          color: AppColors.blueText,
          size: 128,
          left: 50,
          top: 100,
        ),
        _buildAnimatedBubble(
          controller: _controller2,
          color: AppColors.purpleText.withOpacity(0.05),
          size: 80,
          left: 280,
          bottom: 100,
        ),
        _buildAnimatedBubble(
          controller: _controller3,
          color: AppColors.pinkText.withOpacity(0.05),
          size: 96,
          right: 100,
          top: 100,
        ),
      ],
    );
  }

  Widget _buildAnimatedBubble({
    required AnimationController controller,
    required double size,
    required Color color,
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Positioned(
          left: left,
          right: right,
          top: top != null ? top + 10 * controller.value : null,
          bottom: bottom != null ? bottom + 10 * controller.value : null,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.4),
            ),
          ),
        );
      },
    );
  }
}
