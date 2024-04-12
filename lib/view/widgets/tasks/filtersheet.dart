import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/controller/tasks/tasks_bloc.dart';

filteringSheet(BuildContext context) {
  TasksBloc tasksBloc = context.read<TasksBloc>();
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(top: 25.h),
          width: double.infinity,
          height: 200.h,
          child: Column(
            children: [
              Text(
                'Filter tasks by',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              TextButton(
                  onPressed: () {
                    tasksBloc.add(GetTasks());
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'All tasks',
                    style: TextStyle(fontSize: 16.sp),
                  )),
              TextButton(
                  onPressed: () {
                    tasksBloc.add(GetTaskById());
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Tasks by me',
                    style: TextStyle(fontSize: 16.sp),
                  )),
              TextButton(
                  onPressed: () {
                    tasksBloc.add(GetRandomTask());
                    Navigator.of(context).pop();
                  },
                  child:
                      Text('Random task', style: TextStyle(fontSize: 16.sp))),
            ],
          ),
        );
      });
}
