import 'package:shared_preferences/shared_preferences.dart';

class QuestionCache {
  final SharedPreferences prefs;

  QuestionCache(this.prefs);

  Future<void> save(String value) => prefs.setString('cached_question', value);

  String? get() => prefs.getString('cached_question');
}
