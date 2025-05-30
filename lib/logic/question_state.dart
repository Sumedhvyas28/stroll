import '../../data/models/question_model.dart';

abstract class QuestionState {}

class QuestionLoading extends QuestionState {}

class QuestionLoaded extends QuestionState {
  final QuestionModel question;

  QuestionLoaded(this.question);
}

class QuestionError extends QuestionState {
  final String message;

  QuestionError(this.message);
}
