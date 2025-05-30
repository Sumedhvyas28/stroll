import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stroll_app/core/constants/colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const CustomBottomNavigationBar({
    super.key,
    this.currentIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.bottomColor,
        border: Border(top: BorderSide(color: Color(0xFF2A2A2A), width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            index: 0,
            svgPath: 'assets/images/Vector.svg',
            isSelected: currentIndex == 0,
          ),
          _buildNavItem(
            index: 1,
            svgPath: 'assets/images/fire.svg',
            isSelected: currentIndex == 1,
          ),
          _buildNavItem(
            index: 2,
            svgPath: 'assets/images/message.svg',
            isSelected: currentIndex == 2,
          ),
          _buildNavItem(
            index: 3,
            svgPath: 'assets/images/user.svg',
            isSelected: currentIndex == 3,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String svgPath,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => onTap?.call(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              padding: const EdgeInsets.all(6),
              decoration:
                  isSelected
                      ? null
                      // BoxDecoration(
                      //   shape: BoxShape.circle,
                      //   color: AppColors.optionSelected.withOpacity(0.2),
                      //   border: Border.all(
                      //     color: AppColors.optionSelected,
                      //     width: 1.5,
                      //   ),
                      // )
                      : null,
              child: SvgPicture.asset(
                svgPath,
                width: 30,
                height: 30,
                colorFilter: ColorFilter.mode(
                  isSelected
                      ? AppColors.mainFontColor
                      : Colors.white.withOpacity(0.6),
                  BlendMode.srcIn,
                ),
              ),
            ),
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.optionSelected,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
