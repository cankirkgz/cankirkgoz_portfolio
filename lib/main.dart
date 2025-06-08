import 'package:flutter/material.dart';
import 'package:my_portfolio/views/main_page/main_page.dart';

/// Uygulamanın temasını global olarak yönetir.
/// [ThemeToggleIcon] bu notifiere erişip
/// ThemeMode.light ⇆ ThemeMode.dark arasında geçiş yapar.
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, mode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Can Kırkgöz Portfolio',
          themeMode: mode,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF9FAFB),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF1E1E1E),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.indigo,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          // Burada builder ile child'ı Stack içine alıp üzerine overlay ekliyoruz
          builder: (context, child) {
            return Stack(
              children: [
                // Asıl uygulama
                if (child != null) child,
                // Boyutları ekranda gösteren overlay
                const _DimensionOverlay(),
              ],
            );
          },
          home: const MainPage(),
        );
      },
    );
  }
}

/// Her rebuild'de MediaQuery boyutunu alıp
/// 10'ar piksellik adımlarla yuvarlayarak gösterir.
class _DimensionOverlay extends StatelessWidget {
  const _DimensionOverlay();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // En yakın 10luk piksele yuvarla
    final roundedWidth = (size.width ~/ 10) * 10;
    final roundedHeight = (size.height ~/ 10) * 10;

    return Positioned(
      top: 8,
      right: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          '${roundedWidth.toInt()} × ${roundedHeight.toInt()}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
