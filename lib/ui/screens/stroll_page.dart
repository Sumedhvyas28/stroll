import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stroll_app/core/constants/colors.dart';
import 'package:stroll_app/logic/question_cubit.dart';
import 'package:stroll_app/logic/question_state.dart';
import 'package:stroll_app/ui/widgets/custom_bottom_nav.dart';
import 'package:stroll_app/ui/widgets/option_tile.dart';
import 'package:stroll_app/ui/widgets/user_info_tile.dart';

class StrollPage extends StatefulWidget {
  const StrollPage({super.key});

  @override
  State<StrollPage> createState() => _StrollPageState();
}

class _StrollPageState extends State<StrollPage> {
  int _currentIndex = 0;

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
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: MediaQuery.of(context).size.height * 0.55,
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
                            stops: [0.6, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned.fill(
                  top: MediaQuery.of(context).size.height * 0.55,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(1),
                        topRight: Radius.circular(1),
                      ),
                      color: Colors.black,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 70, 16, 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "\"Mine is definitely the peace in the morning.\"",
                            style: TextStyle(
                              color: AppColors.mainTextColor,
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                            ),
                          ),

                          // const SizedBox(height: 24),
                          SizedBox(
                            height: 195,
                            child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 18,
                              mainAxisSpacing: 12,
                              childAspectRatio: 2.5,
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
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Pick your option.",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 1),
                                      Text(
                                        "See who has a similar mind.",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors.mainFontColor,
                                          width: 2.2,
                                        ),
                                        color: Colors.black,
                                      ),
                                      padding: const EdgeInsets.all(12),
                                      child: Image.asset(
                                        'assets/images/mic.png',
                                        height: 20,
                                        width: 20,
                                        color: AppColors.mainFontColor,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.mainFontColor,
                                        border: Border.all(
                                          color: AppColors.mainFontColor,
                                          width: 1.5,
                                        ),
                                      ),

                                      padding: const EdgeInsets.all(12),
                                      child: const Icon(
                                        Icons.arrow_forward,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // const SizedBox(height: 1),
                        ],
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: MediaQuery.of(context).size.height * 0.52,
                  left: 30,
                  right: 16,
                  child: const UserInfoTile(),
                ),
              ],
            );
          }

          return const Center(child: Text("Something went wrong."));
        },
      ),

      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Add navigation logic here
        },
      ),
    );
  }
}
