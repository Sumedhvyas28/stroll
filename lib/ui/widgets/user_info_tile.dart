import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';

class UserInfoTile extends StatelessWidget {
  const UserInfoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58,
      height: 85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage(AppAssets.profile),
            radius: 30,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Angelina, 28",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  'What is your favorite time \nof the day?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
