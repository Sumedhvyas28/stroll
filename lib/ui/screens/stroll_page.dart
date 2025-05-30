import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stroll_app/core/constants/text_styles.dart';
import 'package:stroll_app/logic/question_cubit.dart';
import 'package:stroll_app/logic/question_state.dart';
import 'package:stroll_app/ui/widgets/option_tile.dart';
import 'package:stroll_app/ui/widgets/user_info_tile.dart';

class StrollPage extends StatelessWidget {
  const StrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<QuestionCubit, QuestionState>(
        builder: (context, state) {
          if (state is QuestionLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is QuestionLoaded) {
            final q = state.question;
            return Stack(
              children: [
                // 🔹 Top Half Background Image with internal gradient
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/background.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black54],
                            stops: [0.5, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 🔹 UserInfoTile placed at bottom of image (overlap line)
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.5 - 30,
                  left: 16,
                  right: 16,
                  child: const UserInfoTile(),
                ),

                // 🔹 Bottom Content Container
                Positioned.fill(
                  top: MediaQuery.of(context).size.height * 0.5,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: Colors.black, // ensure solid black bg
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 24), // space below profile
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                q.question,
                                style: AppTextStyles.question.copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "\"Mine is definitely the peace in the morning.\"",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 2.8,
                              physics: const NeverScrollableScrollPhysics(),
                              children: List.generate(q.options.length, (i) {
                                final option = q.options[i];
                                return OptionTile(
                                  index: i,
                                  text: option,
                                  selected: q.selectedOption == option,
                                  onTap:
                                      () => context
                                          .read<QuestionCubit>()
                                          .selectOption(option),
                                );
                              }),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Pick your option.\nSee who has a similar mind.",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.purple,
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: const Icon(
                                        Icons.mic_none,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.purple,
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: const Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text("Something went wrong."));
        },
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.local_activity), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }
}
