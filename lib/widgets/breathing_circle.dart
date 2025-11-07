import 'dart:math' as math;
import 'package:flutter/material.dart';


/// Αναπνέουσα μπάλα: κάνει expand/contract σε σταθερό ρυθμό.
/// Χρησιμοποιείται και ως "στόχος" για timing tap στο GameScreen.
class BreathingCircle extends StatelessWidget {
  final double progress; // 0..1 μέσα στον κύκλο αναπνοής
  final double minRadius;
  final double maxRadius;


  const BreathingCircle({
    super.key,
    required this.progress,
    this.minRadius = 40,
    this.maxRadius = 140,
  });


  @override
  Widget build(BuildContext context) {
// Smooth in/out με ημίτονο, 0..1..0
    final wave = 0.5 - 0.5 * math.cos(progress * 2 * math.pi);
    final radius = minRadius + (maxRadius - minRadius) * wave;


    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.8),
            Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ],
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            spreadRadius: 2,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.35),
          ),
        ],
      ),
    );
  }
}