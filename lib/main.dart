import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stroll_app/data/local/question_local.dart';
import 'package:stroll_app/logic/question_cubit.dart';
import 'package:stroll_app/ui/screens/stroll_page.dart';

import 'data/repository/question_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final cache = QuestionCache(prefs);
  final repo = QuestionRepository(cache);

  runApp(MyApp(repo));
}

class MyApp extends StatelessWidget {
  final QuestionRepository repository;

  const MyApp(this.repository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stroll Bonfire',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: BlocProvider(
        create: (_) => QuestionCubit(repository)..loadQuestion(),
        child: StrollPage(),
      ),
    );
  }
}
