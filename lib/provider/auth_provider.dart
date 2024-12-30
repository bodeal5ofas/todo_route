import 'package:flutter/foundation.dart';
import 'package:todo_app/firestore_logic/firestore_logic.dart';
import 'package:todo_app/models/user_model.dart';

class AuthenticationProvider extends ChangeNotifier {
  MyUserModel? user;

   updateUser(MyUserModel newUser) {
    user = newUser;
  }
  // saveUpdatedDate({required String uId,required String taskid}){
  //   FirestoreLogic.getTask(uId).doc(taskid).
  // }
}
