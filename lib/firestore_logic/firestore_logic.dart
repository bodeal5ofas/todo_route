import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/models/user_model.dart';

class FirestoreLogic {
  static CollectionReference<TaskModel> getTask(String uId) {
    return users.doc(uId).collection('tasks').withConverter<TaskModel>(
          fromFirestore: (snapshot, options) => TaskModel.fromJson(snapshot),
          toFirestore: (task, options) => task.toJson(),
        );
  }

  static Future<void> addTask(TaskModel task, String uId) {
    DocumentReference<TaskModel> taskdoc = getTask(uId).doc();
    task.id = taskdoc.id;
    return taskdoc.set(task);
  }

  static CollectionReference<MyUserModel> users =
      FirebaseFirestore.instance.collection('users').withConverter<MyUserModel>(
            fromFirestore: (snapshot, options) =>
                MyUserModel.fromJson(snapshot.data()!),

            /// possible error because !
            toFirestore: (user, options) => user.ToFirestore(),
          );
  static Future<void> addUserToFireStore(MyUserModel user) {
    return users.doc(user.id).set(user);
  }

  static Future<MyUserModel?> readUserFromFireStore(String uId) async {
    DocumentSnapshot<MyUserModel> documentSnapshot = await users.doc(uId).get();
    return documentSnapshot.data();
  }

  static Future<void> editIsDone(
      {required String uid, required TaskModel task}) {
    return getTask(uid).doc(task.id).update({
      'isDone': task.isDone,
    });
  }

  static Future<void> editTask({required String uid, required TaskModel task}) {
    return getTask(uid).doc(task.id).update(
        //   {
        //   'title':task.title ,
        //   'description':task.description,
        //   'time':task.time.millisecondsSinceEpoch,
        // }
        task.toJson());
  }
}
