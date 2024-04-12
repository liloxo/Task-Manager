import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/constants/colors.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(bottom: 35.h),
      child: InkWell(
          onTap: () {},
          child: const Text("Forgot Password ?",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor))),
    );
  }
}
