import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/constants/colors.dart';
import 'package:task_manager/view/widgets/auth/customtextfield.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController? mycontroller;
  final String? Function(String?)? valid;
  const UsernameField({super.key, this.mycontroller, this.valid});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      valid: (val) {
        if (val!.isEmpty) {
          return 'Field cannot be empty';
        }
        return null;
      },
      mycontroller: mycontroller,
      labeltext: 'Username',
      suffixIcon: Padding(
        padding: EdgeInsets.only(right: 8.h),
        child: Icon(
          Icons.person,
          size: 21.h,
          color: AppColors.primaryColor,
        ),
      ),
      obscureText: false,
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController? mycontroller;
  final String? Function(String?)? valid;
  const PasswordField({
    super.key,
    this.mycontroller,
    this.valid,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isVisible = true;

  changevisibilty() {
    isVisible = !isVisible;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 30.h, bottom: 20.h),
        child: CustomTextFormField(
          obscureText: isVisible,
          valid: (val) {
            if (val!.isEmpty) {
              return 'Field cannot be empty';
            }
            return null;
          },
          mycontroller: widget.mycontroller,
          labeltext: 'Password',
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 5.h),
            child: IconButton(
                onPressed: () {
                  changevisibilty();
                },
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                  size: 23.h,
                  color: AppColors.primaryColor,
                )),
          ),
        ));
  }
}
