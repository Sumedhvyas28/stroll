import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  String _selectedStroll = "Stroll Bonfire";
  final List<String> _strollOptions = [
    "Stroll Bonfire",
    "Stroll Beach",
    "Stroll Mountain",
    "Stroll City",
  ];

  String _formatCurrentTime() {
    final now = DateTime.now();
    final hours = now.hour.toString().padLeft(2, '0');
    final minutes = now.minute.toString().padLeft(2, '0');
    return "${hours}h ${minutes}m";
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final topPadding = MediaQuery.of(context).padding.top;

    // Make background height responsive
    final backgroundHeight = screenHeight * 0.55;
    final bottomSectionTop = backgroundHeight;

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
                // Background Image Section
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: backgroundHeight,
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

                // Header Section (Dropdown and Info)
                Positioned(
                  top: topPadding + 20,
                  left: 16,
                  right: 16,
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Dropdown
                        GestureDetector(
                          onTap: () {
                            _showStrollDropdown(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    _selectedStroll,
                                    style: TextStyle(
                                      color: AppColors.textAppColor,
                                      fontSize: screenWidth < 350 ? 28 : 34,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppColors.textAppColor,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 1),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.white.withOpacity(0.8),
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _formatCurrentTime(),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Icon(
                              Icons.people_outline,
                              color: Colors.white.withOpacity(0.8),
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "103",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom Content Section (Made Scrollable)
                Positioned.fill(
                  top: bottomSectionTop,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(1),
                        topRight: Radius.circular(1),
                      ),
                      color: Colors.black,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          16,
                          70,
                          16,
                          16 + MediaQuery.of(context).padding.bottom,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Text(
                                "\"Mine is definitely the peace in the morning.\"",
                                style: TextStyle(
                                  color: AppColors.mainTextColor,
                                  fontStyle: FontStyle.italic,
                                  fontSize: screenWidth < 350 ? 16 : 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            LayoutBuilder(
                              builder: (context, constraints) {
                                double gridHeight =
                                    q.options.length <= 4
                                        ? 195
                                        : (q.options.length / 2).ceil() * 97.5;
                                if (screenHeight < 700) {
                                  gridHeight = math.min(
                                    gridHeight,
                                    screenHeight * 0.25,
                                  );
                                }

                                return SizedBox(
                                  height: gridHeight,
                                  child: GridView.count(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 18,
                                    mainAxisSpacing: 12,
                                    childAspectRatio:
                                        screenWidth < 350 ? 2.2 : 2.5,
                                    physics:
                                        q.options.length > 4
                                            ? const BouncingScrollPhysics()
                                            : const NeverScrollableScrollPhysics(),
                                    children: List.generate(q.options.length, (
                                      i,
                                    ) {
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
                                );
                              },
                            ),

                            const SizedBox(height: 12),

                            // Bottom Action Section
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            fontSize:
                                                screenWidth < 350 ? 13 : 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 1),
                                        Text(
                                          "See who has a similar mind.",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                screenWidth < 350 ? 13 : 14,
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
                                        padding: EdgeInsets.all(
                                          screenWidth < 350 ? 10 : 12,
                                        ),
                                        child: Image.asset(
                                          'assets/images/mic.png',
                                          height: screenWidth < 350 ? 18 : 20,
                                          width: screenWidth < 350 ? 18 : 20,
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
                                        padding: EdgeInsets.all(
                                          screenWidth < 350 ? 10 : 12,
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.black,
                                          size: screenWidth < 350 ? 18 : 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height:
                                  MediaQuery.of(context).padding.bottom + 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // User Info Tile - Made responsive
                Positioned(
                  top: bottomSectionTop - (screenHeight * 0.03),
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
          // Add your navigation logic here
        },
      ),
    );
  }

  void _showStrollDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true, // Make modal responsive
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),

              // Make options scrollable if they exceed screen space
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children:
                        _strollOptions.map((option) {
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 4,
                            ),
                            title: Text(
                              option,
                              style: TextStyle(
                                color:
                                    _selectedStroll == option
                                        ? AppColors.optionSelected
                                        : Colors.white,
                                fontSize: 16,
                                fontWeight:
                                    _selectedStroll == option
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                              ),
                            ),
                            trailing:
                                _selectedStroll == option
                                    ? const Icon(
                                      Icons.check,
                                      color: AppColors.optionSelected,
                                    )
                                    : null,
                            onTap: () {
                              setState(() {
                                _selectedStroll = option;
                              });
                              Navigator.pop(context);
                            },
                          );
                        }).toList(),
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
            ],
          ),
        );
      },
    );
  }
}
