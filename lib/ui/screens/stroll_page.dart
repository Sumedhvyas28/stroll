import 'package:flutter/material.dart';

class StrollPage extends StatelessWidget {
  const StrollPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
