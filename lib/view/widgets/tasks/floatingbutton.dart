import 'package:flutter/material.dart';
import 'package:task_manager/core/constants/colors.dart';
import 'package:task_manager/view/widgets/tasks/addtasksheet.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.primary,
      onPressed: () {
        addtaskSheet(context);
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
