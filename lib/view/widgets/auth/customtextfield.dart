import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/constants/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? mycontroller;
  final TextInputType? keyboardType;
  final String? hintText;
  final String labeltext;
  final Widget? prefixIcon;
  final String? Function(String?)? valid;
  final Widget? suffixIcon;
  final bool obscureText;
  const CustomTextFormField(
      {super.key,
      this.mycontroller,
      this.keyboardType,
      this.hintText,
      required this.labeltext,
      this.prefixIcon,
      this.valid,
      this.suffixIcon,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      style: TextStyle(
          fontSize: 16.sp, fontWeight: FontWeight.w500, letterSpacing: 1),
      controller: mycontroller,
      validator: valid,
      keyboardType: keyboardType,
      cursorColor: AppColors.secondaryColor,
      decoration: InputDecoration(
          focusColor: AppColors.secondaryColor,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(
                  width: 2.2, color: AppColors.secondaryColor)),
          contentPadding:
              EdgeInsets.symmetric(vertical: 11.h, horizontal: 15.h),
          label: Text(labeltext,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500)),
          //floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hintText,
          prefixIcon: prefixIcon,
          prefixIconColor: AppColors.secondaryColor,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          disabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1, color: AppColors.thirdColor),
              borderRadius: BorderRadius.circular(25))),
    );
  }
}
