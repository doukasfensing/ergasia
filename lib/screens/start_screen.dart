import 'dart:math';
import 'package:flutter/material.dart';
import '../data/tips.dart';
import 'game_screen.dart';


class StartScreen extends StatelessWidget {
  const StartScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final tip = tips[Random().nextInt(tips.length)];


    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Text('Relax Flow', style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 8),
              Text('Mini‑game για χαλάρωση μέσω αναπνοής και εστίασης.'),
              const Spacer(),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.light_mode),
                      const SizedBox(width: 12),
                      Expanded(child: Text(tip)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GameScreen()),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text('Ξεκίνα 1‑λεπτο κύκλο'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}