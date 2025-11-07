import 'package:shared_preferences/shared_preferences.dart';


class LocalStore {
  static const _kTotalSessions = 'total_sessions';
  static const _kLastScore = 'last_score';
  static const _kLastRating = 'last_rating';


  Future<void> saveSession({required int score, required int rating}) async {
    final sp = await SharedPreferences.getInstance();
    final total = sp.getInt(_kTotalSessions) ?? 0;
    await sp.setInt(_kTotalSessions, total + 1);
    await sp.setInt(_kLastScore, score);
    await sp.setInt(_kLastRating, rating);
  }


  Future<int> get totalSessions async =>
      (await SharedPreferences.getInstance()).getInt(_kTotalSessions) ?? 0;
  Future<int?> get lastScore async =>
      (await SharedPreferences.getInstance()).getInt(_kLastScore);
  Future<int?> get lastRating async =>
      (await SharedPreferences.getInstance()).getInt(_kLastRating);
}