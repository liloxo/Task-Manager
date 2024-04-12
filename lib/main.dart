import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/controller/tasks/tasks_bloc.dart';
import 'package:task_manager/view/pages/tasks/tasks.dart';
import 'view/pages/auth/auth.dart';

late SharedPreferences sharedPreferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool signed = sharedPreferences.getBool('signed') ?? false;
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => TasksBloc()..add(GetTasks()),
                child: const Tasks(),
              )
            ],
            child: MaterialApp(
              routes: {
                '/auth': (context) => const AuthPage(),
              },
              debugShowCheckedModeBanner: false,
              home: signed ? const Tasks() : const AuthPage(),
            ));
      },
    );
  }
}
