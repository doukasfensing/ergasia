import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../widgets/breathing_circle.dart';
import 'result_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  late AnimationController _ac;

  static const _cycleSeconds = 6.0;        // 1 breathing cycle = 6 seconds
  static const _totalCycles = 10;          // ~60 seconds total
  int _completedCycles = 0;
  int _score = 0;
  String _cue = 'Εισπνοή…';

  @override
  void initState() {
    super.initState();

    _ac = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (_cycleSeconds * 1000).toInt()),
    )..addListener(_onTick)
      ..repeat();
  }

  void _onTick() {
    final p = _ac.value; // 0..1
    setState(() {
      _cue = p < 0.5 ? 'Εισπνοή…' : 'Εκπνοή…';
    });
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  void _handleTap() {
    final p = _ac.value; // 0..1 — where we are in the breathing cycle

    /// Perfect tap = close to peak (0.5)
    final diff = (p - 0.5).abs();

    int points;
    if (diff <= 0.05) {
      points = 100;
    } else if (diff <= 0.1) {
      points = 60;
    } else if (diff <= 0.2) {
      points = 30;
    } else {
      points = 0;
    }

    setState(() => _score += points);

    /// When we cross the midpoint (peak), count a completed cycle
    if (p >= 0.5) {
      _completedCycles++;
      if (_completedCycles >= _totalCycles) {
        _finish();
      }
    }
  }

  void _finish() {
    _ac.stop();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(score: _score),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress = _ac.value;

    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Κύκλος: ${math.min(_completedCycles + 1, _totalCycles)}/$_totalCycles'),
                    Text('Σκορ: $_score'),
                  ],
                ),
                const SizedBox(height: 24),

                Expanded(
                  child: Center(
                    child: BreathingCircle(
                      progress: progress,
                      minRadius: 40,
                      maxRadius: 140,
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                Text(_cue, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text('Άγγιξε όταν ο κύκλος είναι στο μέγιστο μέγεθος.', textAlign: TextAlign.center),
                const SizedBox(height: 24),

                FilledButton(
                  onPressed: _finish,
                  child: const Text('Τερματισμός'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
