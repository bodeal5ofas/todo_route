// import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/component/custom_text_form.dart';
import 'package:todo_app/firestore_logic/firestore_logic.dart';
import 'package:todo_app/helper/dialog_utils.dart';
import 'package:todo_app/home/home_view.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/provider/auth_provider.dart';
import 'package:todo_app/register/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String id = 'login page';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var emailController = TextEditingController(text: 'bola1@root.com');
  var keyForm = GlobalKey<FormState>();
  var passwordController = TextEditingController(text: '1234567');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          SingleChildScrollView(
              child: Form(
            key: keyForm,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .3,
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    vaildator: (email) {
                      if (email == null || email.trim().isEmpty) {
                        return 'Please Enter User Email';
                      }
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email);
                      if (!emailValid) {
                        return 'Please Enter Vaild Email';
                      }

                      return null;
                    },
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    label: 'Password',
                    isPassword: true,
                    vaildator: (password) {
                      if (password == null || password.trim().isEmpty) {
                        return 'Please Enter User Password';
                      }
                      if (password.length < 6) {
                        return 'password is less than 6 character';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor),
                    onPressed: () async {
                      if (keyForm.currentState!.validate()) {
                        // sign in account;
                        DialogUtils.showLoading(context);
                        try {
                          final userCredential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          MyUserModel? user =
                              await FirestoreLogic.readUserFromFireStore(
                                  userCredential.user?.uid ?? '');
                          if (user == null) {
                            return;
                          }
                             
                          var authProvider =
                              Provider.of<AuthenticationProvider>(context,listen: false);
                          authProvider.updateUser(user);
                          DialogUtils.closeLoading(context);
                          DialogUtils.showMessage(
                            context,
                            message: 'Successfull Login',
                            posActionTitle: 'okay',
                            posAction: () {
                              Navigator.pushReplacementNamed(context, HomeView.id);
                            },
                          );
                        } on FirebaseAuthException catch (e) {
                          DialogUtils.closeLoading(context);
                          if (e.code == 'user-not-found') {
                            DialogUtils.showMessage(context,
                                posActionTitle: 'okay',
                                message: 'No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            DialogUtils.showMessage(context,
                                posActionTitle: 'okay',
                                message:
                                    'Wrong password provided for that user.');
                          }
                        } catch (e) {
                          DialogUtils.closeLoading(context);
                          DialogUtils.showMessage(context,
                              posActionTitle: 'okay', message: e.toString());
                        }
                      }
                    },
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Donot Have An Account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterView.id);
                        },
                        child: Text(
                          "Sign Up ",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
