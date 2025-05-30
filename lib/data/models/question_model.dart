class QuestionModel {
  final String id;
  final String question;
  final List<String> options;
  final String? selectedOption;

  QuestionModel({
    required this.id,
    required this.question,
    required this.options,
    this.selectedOption,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
    id: json['id'],
    question: json['question'],
    options: List<String>.from(json['options']),
    selectedOption: json['selectedOption'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'question': question,
    'options': options,
    'selectedOption': selectedOption,
  };

  QuestionModel copyWith({String? selectedOption}) => QuestionModel(
    id: id,
    question: question,
    options: options,
    selectedOption: selectedOption,
  );

  static QuestionModel mock() => QuestionModel(
    id: '1',
    question: 'What is your favorite time of the day?',
    options: [
      'The peace in the early mornings',
      'The magical golden hours',
      'Wind-down time after dinners',
      'The serenity past midnight',
    ],
  );
}
