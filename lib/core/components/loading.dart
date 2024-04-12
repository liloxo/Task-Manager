import 'package:flutter/material.dart';
import 'package:task_manager/core/constants/colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
        strokeWidth: 8,
      ),
    );
  }
}
