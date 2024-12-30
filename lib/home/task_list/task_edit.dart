import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firestore_logic/firestore_logic.dart';
import 'package:todo_app/helper/dialog_utils.dart';
//import 'package:todo_app/home/task_list/task_iteam.dart';
import 'package:todo_app/models/task_model.dart';
//import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/provider/auth_provider.dart';
import 'package:todo_app/provider/list_provider.dart';

class TaskEdit extends StatefulWidget {
  const TaskEdit({
    super.key,
    required this.taskModel,
  });
  final TaskModel taskModel;

  @override
  State<TaskEdit> createState() => _TaskEditState();
}

class _TaskEditState extends State<TaskEdit> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var user = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      body:
          //  Container(
          //   width: double.infinity,
          //   padding: const EdgeInsets.all(16),
          //   child:
          Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                textAlign: TextAlign.center,
                AppLocalizations.of(context)!.edit_task,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: widget.taskModel.title,
                  hintStyle: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: widget.taskModel.description,
                  hintStyle: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.select_date,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    var currentTime = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          const Duration(
                            days: 90,
                          ),
                        ),
                        initialDate:
                            DateTime.now() //    الوقت اللي هيكون مختاره,
                        );
                    if (currentTime != null) {
                      time = currentTime;
                    } else {
                      time = widget.taskModel.time;
                    }
                    setState(() {});
                  },
                  child: Text(
                    textAlign: TextAlign.center,
                    '${widget.taskModel.time.day}/${widget.taskModel.time.month}/${widget.taskModel.time.year}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: () async {
                  if (titleController.text.isNotEmpty) {
                    widget.taskModel.title = titleController.text;
                  }
                  if (descriptionController.text.isNotEmpty) {
                    widget.taskModel.description = descriptionController.text;
                  }
                  widget.taskModel.time = time;

                  listProvider.updateTask(widget.taskModel, user.user!.id);

                  //   listProvider.getAllTasks(user.user!.id);

                  // DialogUtils.showMessage(context,
                  //     message: 'Updated Successfully', posActionTitle: 'OK');
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.edit_task,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    //   );
  }
}
