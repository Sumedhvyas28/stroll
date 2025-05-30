import 'package:flutter/material.dart';
import '../../core/constants/app_assets.dart';

class UserInfoTile extends StatelessWidget {
  const UserInfoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(backgroundImage: AssetImage(AppAssets.profile)),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Angelina, 28", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              '"Mine is definitely the peace in the morning."',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
