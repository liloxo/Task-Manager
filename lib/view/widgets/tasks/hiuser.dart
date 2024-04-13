import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/constants/colors.dart';
import 'package:task_manager/main.dart';

class HiUser extends StatelessWidget {
  final void Function()? onPressed;
  const HiUser({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    String username = sharedPreferences.getString('username')!;
    return Row(
      children: [
        CircleAvatar(
          radius: 20.h,
          backgroundColor: AppColors.primary,
          child: Center(
              child: Text(
            username[0].toUpperCase(),
            style: TextStyle(color: Colors.white, fontSize: 20.sp),
          )),
        ),
        Container(
          margin: EdgeInsets.only(left: 20.w),
          width: 200.w,
          child: Text.rich(
              TextSpan(children: [
                TextSpan(
                    text: 'Hi, ',
                    style: TextStyle(
                        fontSize: 20.sp, fontWeight: FontWeight.w400)),
                TextSpan(
                    text: username,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    )),
              ]),
              overflow: TextOverflow.ellipsis),
        ),
        IconButton(
            onPressed: () {
              sharedPreferences.clear();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/auth', (route) => false);
            },
            icon: const Icon(
              Icons.logout,
              color: AppColors.primary,
            ))
      ],
    );
  }
}
