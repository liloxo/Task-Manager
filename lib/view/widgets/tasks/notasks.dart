import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoTasks extends StatelessWidget {
  const NoTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No Tasks',
        style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w500),
      ),
    );
  }
}
