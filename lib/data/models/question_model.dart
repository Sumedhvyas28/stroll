class QuestionModel {
  final String id;
  final List<String> options;
  final String? selectedOption;

  QuestionModel({required this.id, required this.options, this.selectedOption});

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
    id: json['id'],
    options: List<String>.from(json['options']),
    selectedOption: json['selectedOption'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'options': options,
    'selectedOption': selectedOption,
  };

  QuestionModel copyWith({String? selectedOption}) =>
      QuestionModel(id: id, options: options, selectedOption: selectedOption);

  static QuestionModel mock() => QuestionModel(
    id: '1',
    options: [
      'The peace in the early mornings',
      'The magical golden hours',
      'Wind-down time after dinners',
      'The serenity past midnight',
    ],
  );
}
