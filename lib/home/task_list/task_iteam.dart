import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firestore_logic/firestore_logic.dart';
import 'package:todo_app/home/task_list/task_edit.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/provider/app_config_provider.dart';
import 'package:todo_app/provider/auth_provider.dart';
import 'package:todo_app/provider/list_provider.dart';

class TaskIteam extends StatefulWidget {
  const TaskIteam({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  State<TaskIteam> createState() => _TaskIteamState();
}

class _TaskIteamState extends State<TaskIteam> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthenticationProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (context) {
                listProvider.deleteTask(
                    widget.taskModel, authProvider.user!.id);
                listProvider.getAllTasks(authProvider.user!.id);
              },
              backgroundColor: MyTheme.redColor,
              icon: Icons.delete,
              label: "Delete",
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskEdit(
                  taskModel: widget.taskModel,
                ),
              ),
            );
          },
          // onTap: () => showBottomSheet(
          //   context: context,
          //   builder: (context) => TaskEdit(taskModel:taskModel ,),
          // ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: MyTheme.whiteColor,
            ),
            padding: const EdgeInsets.all(16),
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                VerticalDivider(
                  color: widget.taskModel.isDone == true
                      ? MyTheme.greenLight
                      : Theme.of(context).primaryColor,
                  thickness: 2,
                  indent: 10,
                  endIndent: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          widget.taskModel.title,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: widget.taskModel.isDone == true
                                        ? MyTheme.greenLight
                                        : Theme.of(context).primaryColor,
                                  ),
                        ),
                        Text(
                          widget.taskModel.description,
                          style: provider.appMode == ThemeMode.dark
                              ? Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.black)
                              : Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.taskModel.isDone = !widget.taskModel.isDone;
                    FirestoreLogic.editIsDone(
                        uid: authProvider.user!.id, task: widget.taskModel);
                    setState(() {});
                  },
                  child: widget.taskModel.isDone == true
                      ? Text(
                          'Done!',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: MyTheme.greenLight),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Icon(
                            Icons.check,
                            color: MyTheme.whiteColor,
                            size: 25,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
