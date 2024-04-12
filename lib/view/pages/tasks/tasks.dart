import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/controller/tasks/tasks_bloc.dart';
import 'package:task_manager/core/components/loading.dart';
import 'package:task_manager/view/widgets/tasks/filtersheet.dart';
import 'package:task_manager/view/widgets/tasks/floatingbutton.dart';
import 'package:task_manager/view/widgets/tasks/hiuser.dart';
import 'package:task_manager/view/widgets/tasks/notasks.dart';
import 'package:task_manager/view/widgets/tasks/tasksfiltering.dart';
import 'package:task_manager/view/widgets/tasks/taskslist.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FloatingButton(),
      body: Container(
        margin: EdgeInsets.all(20.h),
        padding: EdgeInsets.only(top: 50.h),
        child: Column(
          children: [
            const HiUser(),
            TasksFiltering(
              onPressed: () {
                filteringSheet(context);
              },
            ),
            Expanded(
              child: BlocConsumer<TasksBloc, TasksState>(
                builder: (context, state) {
                  if (state is TasksSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        state.tasksModel!.isEmpty
                            ? const NoTasks()
                            : TasksList(
                                tasksModel: state.tasksModel,
                              ),
                        state.pagination ? const Loading() : const SizedBox()
                      ],
                    );
                  } else if (state is TasksLoading) {
                    return const Loading();
                  } else if (state is TasksFailure) {
                    return Center(
                      child: Text(state.error),
                    );
                  }
                  return const SizedBox();
                },
                listener: (BuildContext context, TasksState state) {
                  if (state is ExcutionFailed) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                  } else if (state is ExcutionSucceed) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
