import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelloImage extends StatelessWidget {
  const HelloImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 40.h),
        height: 260,
        width: double.infinity,
        child: Image.asset('assets/hello.png'),
      ),
    );
  }
}
