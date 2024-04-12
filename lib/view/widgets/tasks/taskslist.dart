import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/controller/tasks/tasks_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_manager/core/constants/colors.dart';
import 'package:task_manager/data/model/tasks/taskmodel.dart';
import 'package:task_manager/view/widgets/tasks/edittasksheet.dart';

class TasksList extends StatefulWidget {
  final List<TaskModel>? tasksModel;
  const TasksList({super.key, required this.tasksModel});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  ScrollController scrollController = ScrollController();
  late TasksBloc tasksBloc;

  @override
  void initState() {
    tasksBloc = BlocProvider.of<TasksBloc>(context);
    tasksBloc.forpagination
        ? scrollController.addListener(() async {
            if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent) {
              tasksBloc.add(GetTasksPagination());
            }
          })
        : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
            controller: scrollController,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10.h,
              );
            },
            padding: EdgeInsets.symmetric(vertical: 10.h),
            itemCount: widget.tasksModel!.length,
            itemBuilder: (context, i) {
              return Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      borderRadius: BorderRadius.circular(20),
                      onPressed: (context) {
                        tasksBloc
                            .add(DeleteTask(id: widget.tasksModel![i].id!));
                      },
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    SlidableAction(
                      borderRadius: BorderRadius.circular(20),
                      onPressed: (context) {
                        editsheet(context, widget.tasksModel![i]);
                      },
                      backgroundColor: const Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                  ],
                ),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.grey,
                    ),
                    height: 70.h,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          child: CircleAvatar(
                              radius: 10.h,
                              backgroundColor: widget.tasksModel![i].completed!
                                  ? AppColors.primary
                                  : AppColors.thirdColor,
                              child: widget.tasksModel![i].completed!
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 15.h,
                                    )
                                  : null),
                        ),
                        SizedBox(
                            width: 240.w,
                            child: Text(
                              widget.tasksModel![i].todo!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15.sp),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            )),
                      ],
                    )),
              );
            }));
  }
}
