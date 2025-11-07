import 'package:flutter/material.dart';
import '../services/local_store.dart';
import '../widgets/star_rating.dart';
import 'start_screen.dart';


class ResultScreen extends StatefulWidget {
  final int score;
  const ResultScreen({super.key, required this.score});


  @override
  State<ResultScreen> createState() => _ResultScreenState();
}


class _ResultScreenState extends State<ResultScreen> {
  int rating = 4;
  bool saving = false;
  final store = LocalStore();
  Future<void> _save() async {
    setState(() => saving = true);
    await store.saveSession(score: widget.score, rating: rating);
    if (!mounted) return;
    setState(() => saving = false);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ευχαριστούμε!'),
        content: Text('Αποθήκευση τοπικά ολοκληρώθηκε.Σκορ: ${widget.score} — Βαθμολογία: $rating/5'),
        actions: [
            TextButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const StartScreen()),
            (_) => false,
      ),
      child: const Text('ΟΚ'),
    ),
    ],
    ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Αποτελέσματα')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Σκορ', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('${widget.score}', style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 32),
            const Text('Πόσο σε βοήθησε;'),
            const SizedBox(height: 8),
            Center(
              child: StarRating(
                value: rating,
                onChanged: (v) => setState(() => rating = v),
              ),
            ),
            const Spacer(),
            FilledButton(
              onPressed: saving ? null : _save,
              child: Text(saving ? 'Αποθήκευση…' : 'Αποθήκευση τοπικά'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Πίσω'),
            )
          ],
        ),
      ),
    );
  }
}