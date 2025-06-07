import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/core/constants/app_colors.dart';

class AnimatedAchievementBanner extends StatefulWidget {
  const AnimatedAchievementBanner({Key? key}) : super(key: key);

  @override
  _AnimatedAchievementBannerState createState() =>
      _AnimatedAchievementBannerState();
}

class _AnimatedAchievementBannerState extends State<AnimatedAchievementBanner> {
  double _xPosition = 0;
  double _yPosition = 0;
  final double _maxTilt = 10; // Maksimum eğim açısı
  final double _lightIntensity = 0.3; // Işık yoğunluğu

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (details) {
        final box = context.findRenderObject() as RenderBox;
        final localPosition = box.globalToLocal(details.localPosition);

        setState(() {
          // Fare pozisyonunu -1 ile 1 arasında normalize et
          _xPosition = (localPosition.dx / box.size.width) * 2 - 1;
          _yPosition = (localPosition.dy / box.size.height) * 2 - 1;
        });
      },
      onExit: (_) {
        setState(() {
          _xPosition = 0;
          _yPosition = 0;
        });
      },
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) // Perspektif ekler
          ..rotateX(_yPosition *
              _maxTilt *
              0.0174533) // Y ekseninde döndür (radyan cinsinden)
          ..rotateY(-_xPosition * _maxTilt * 0.0174533), // X ekseninde döndür
        alignment: FractionalOffset.center,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _adjustColor(AppColors.primary, _xPosition, _yPosition),
                _adjustColor(AppColors.primaryPurple, _xPosition, _yPosition),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: Offset(_xPosition * 5, _yPosition * 5),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _AchievementItem(
                  icon: FontAwesomeIcons.trophy,
                  value: '1+',
                  label: 'Yıllık Deneyim'),
              _AchievementItem(
                  icon: FontAwesomeIcons.projectDiagram,
                  value: '3+',
                  label: 'Geliştirilen Proje'),
              _AchievementItem(
                  icon: FontAwesomeIcons.codeBranch,
                  value: '300+',
                  label: 'Commit'),
            ],
          ),
        ),
      ),
    );
  }

  Color _adjustColor(Color baseColor, double x, double y) {
    // Işığın geldiği yöne göre renk tonunu ayarla
    final intensity = 1 - (_lightIntensity * (1 - (x.abs() + y.abs()) / 2));
    return Color.fromARGB(
      baseColor.alpha,
      (baseColor.red * intensity).clamp(0, 255).toInt(),
      (baseColor.green * intensity).clamp(0, 255).toInt(),
      (baseColor.blue * intensity).clamp(0, 255).toInt(),
    );
  }
}

class _AchievementItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _AchievementItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 36, color: Colors.white),
        const SizedBox(height: 8),
        Text(value,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white70)),
      ],
    );
  }
}
