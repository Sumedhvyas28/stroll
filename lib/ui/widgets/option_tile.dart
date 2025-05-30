import 'package:flutter/material.dart';
import 'package:stroll_app/core/constants/colors.dart';

class OptionTile extends StatelessWidget {
  final int index;
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.index,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final label = String.fromCharCode(65 + index);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.boxButtonColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.mainFontColor : Colors.transparent,
            width: 1.8,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color:
                    selected
                        ? AppColors.mainFontColor
                        : AppColors.boxButtonColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 15,
                  height: 1.3,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
