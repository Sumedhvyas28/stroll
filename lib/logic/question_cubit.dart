import 'package:flutter_bloc/flutter_bloc.dart';
import 'question_state.dart';
import '../../data/repository/question_repository.dart';

class QuestionCubit extends Cubit<QuestionState> {
  final QuestionRepository repository;

  QuestionCubit(this.repository) : super(QuestionLoading());

  void loadQuestion() async {
    try {
      final question = await repository.getQuestion();
      emit(QuestionLoaded(question));
    } catch (e) {
      emit(QuestionError('Failed to load question'));
    }
  }

  void selectOption(String selected) async {
    if (state is QuestionLoaded) {
      final question = (state as QuestionLoaded).question.copyWith(
        selectedOption: selected,
      );
      emit(QuestionLoaded(question));
      await repository.saveQuestion(question);
    }
  }
}
