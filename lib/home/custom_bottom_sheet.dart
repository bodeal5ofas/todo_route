import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firestore_logic/firestore_logic.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/provider/auth_provider.dart';
import 'package:todo_app/provider/list_provider.dart';

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({super.key});

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  var time = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = '', description = '';

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthenticationProvider>(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                textAlign: TextAlign.center,
                AppLocalizations.of(context)!.add_new_task,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              TextFormField(
                onChanged: (value) {
                  title = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field is required';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.enter_task_title,
                  hintStyle: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  description = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field is required';
                  } else {
                    return null;
                  }
                },
                maxLines: 4,
                decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(context)!.enter_task_discription,
                  hintStyle: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.select_date,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
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
                      initialDate: time,
                    );
                    if (currentTime != null) {
                      time = currentTime;
                      setState(() {});
                    }
                  },
                  child: Text(
                    textAlign: TextAlign.center,
                    '${time.day}/${time.month}/${time.year}',
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
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    //add to database
                    FirestoreLogic.addTask(
                            TaskModel(
                              title: title,
                              description: description,
                              time: time,
                            ),
                            authProvider.user!.id)
                        .timeout(
                      Duration(milliseconds: 500),
                      onTimeout: () {
                        log('added succesfully');
                      },
                    );
                    listProvider.getAllTasks(authProvider.user!.id);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.add,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
