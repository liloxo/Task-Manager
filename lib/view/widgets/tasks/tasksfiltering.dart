import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/constants/colors.dart';

class TasksFiltering extends StatelessWidget {
  final void Function()? onPressed;
  const TasksFiltering({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20.h),
          child: Text(
            'Tasks',
            style: TextStyle(fontSize: 27.sp, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.tune,
              size: 25.h,
              color: AppColors.primaryColor,
            ))
      ],
    );
  }
}
