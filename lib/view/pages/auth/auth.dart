import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/controller/auth/login_cubit.dart';
import 'package:task_manager/core/components/loading.dart';
import 'package:task_manager/view/pages/tasks/tasks.dart';
import 'package:task_manager/view/widgets/auth/custombutton.dart';
import 'package:task_manager/view/widgets/auth/showerror.dart';
import 'package:task_manager/view/widgets/auth/usernamepasswordfield.dart';
import 'package:task_manager/view/widgets/auth/forgetpassword.dart';
import 'package:task_manager/view/widgets/auth/helloimage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    GlobalKey<FormState> key = GlobalKey();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
          body: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(25.h),
                  child: BlocConsumer<LoginCubit, LoginState>(
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 2.1),
                            child: const Loading());
                      } else {
                        return Form(
                          key: key,
                          child: Column(
                            children: [
                              const HelloImage(),
                              UsernameField(
                                mycontroller: username,
                              ),
                              PasswordField(
                                mycontroller: password,
                              ),
                              const ForgetPassword(),
                              CustomBotton(
                                onTapSignin: () {
                                  if (key.currentState!.validate()) {
                                    context
                                        .read<LoginCubit>()
                                        .login(username.text, password.text);
                                  }
                                },
                              )
                            ],
                          ),
                        );
                      }
                    },
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Tasks(),
                            ));
                      } else if (state is LoginFailure) {
                        showError(context, state.error);
                      }
                    },
                  )))),
    );
  }
}
