import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_app/firestore_logic/firestore_logic.dart';
import 'package:todo_app/models/task_model.dart';

class ListProvider extends ChangeNotifier {
  List<TaskModel> tasksList = [];
  DateTime selctedTime = DateTime.now();
  getAllTasks(String uId) async {
    QuerySnapshot<TaskModel> currentTasks =
        await FirestoreLogic.getTask(uId).get();
    tasksList = currentTasks.docs.map(
      (doc) {
        return doc.data();
      },
    ).toList();
    tasksList = tasksList.where(
      (task) {
        if (task.time.day == selctedTime.day &&
            task.time.month == selctedTime.month &&
            task.time.year == selctedTime.year) {
          return true;
        }
        return false;
      },
    ).toList();

    tasksList.sort(
      (task1, task2) {
        return task1.time.compareTo(task2.time);
      },
    );
    notifyListeners();
  }

  deleteTask(TaskModel task, String uId) async {
    await FirestoreLogic.getTask(uId).doc(task.id).delete();
    notifyListeners();
  }

  updateTask(TaskModel task, String uId) async {
    await FirestoreLogic.getTask(uId).doc(task.id).update(task.toJson());
    notifyListeners();
  }
}
