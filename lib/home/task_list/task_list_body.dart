import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home/task_list/task_iteam.dart';
import 'package:todo_app/provider/app_config_provider.dart';
import 'package:todo_app/provider/auth_provider.dart';
import 'package:todo_app/provider/list_provider.dart';

class TaskListBody extends StatefulWidget {
  const TaskListBody({super.key});

  @override
  State<TaskListBody> createState() => _TaskListBodyState();
}

class _TaskListBodyState extends State<TaskListBody> {
  @override
  void initState() {
   late var auth = Provider.of<AuthenticationProvider>(context);
   // Provider.of<ListProvider>(context).getAllTasks(auth.user!.id);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthenticationProvider>(context);
    if (listProvider.tasksList.isEmpty) {
      listProvider.getAllTasks(authProvider.user!.id);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: listProvider.selctedTime,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              listProvider.selctedTime = date;
              listProvider.getAllTasks(authProvider.user!.id);
            },
            leftMargin: 24,
            activeBackgroundDayColor: Theme.of(context).primaryColor,
            monthColor: provider.appMode == ThemeMode.dark
                ? Colors.white
                : Colors.black,
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: listProvider.tasksList.length,
            itemBuilder: (context, index) => TaskIteam(
              taskModel: listProvider.tasksList[index],
            ),
          ))
        ],
      ),
    );
  }
}
