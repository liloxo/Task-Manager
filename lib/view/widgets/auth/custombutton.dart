import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/constants/colors.dart';

class CustomBotton extends StatelessWidget {
  final void Function() onTapSignin;
  const CustomBotton({
    super.key,
    required this.onTapSignin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          margin: EdgeInsets.symmetric(horizontal: 8.h),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 45.h,
          width: double.infinity,
          child: InkWell(
            onTap: onTapSignin,
            child: Center(
                child: Text('Log In',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp,
                        letterSpacing: 1.5))),
          )),
    ]);
  }
}
