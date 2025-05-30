import 'dart:convert';
import 'package:stroll_app/data/local/question_local.dart';

import '../models/question_model.dart';

class QuestionRepository {
  final QuestionCache cache;

  QuestionRepository(this.cache);

  Future<QuestionModel> getQuestion() async {
    final cached = cache.get();
    if (cached != null) {
      return QuestionModel.fromJson(json.decode(cached));
    }

    final question = QuestionModel.mock();
    await cache.save(json.encode(question.toJson()));
    return question;
  }

  Future<void> saveQuestion(QuestionModel question) async {
    await cache.save(json.encode(question.toJson()));
  }
}
