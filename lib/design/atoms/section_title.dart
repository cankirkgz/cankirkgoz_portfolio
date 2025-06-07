import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final TextAlign textAlign;
  final EdgeInsetsGeometry padding;
  final TextStyle? style;

  const SectionTitle({
    super.key,
    required this.title,
    this.textAlign = TextAlign.start,
    this.padding = const EdgeInsets.symmetric(vertical: 16.0),
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: style ??
          Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
    );
  }
}
