import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/component/custom_text_form.dart';
import 'package:todo_app/firestore_logic/firestore_logic.dart';
import 'package:todo_app/helper/dialog_utils.dart';
import 'package:todo_app/home/home_view.dart';
import 'package:todo_app/login/login_view.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/provider/auth_provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static String id = 'register id';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  var textController = TextEditingController(text: 'bola');
  var emailController = TextEditingController(text: 'bola1@root.com');
  var passwordController = TextEditingController(text: '1234567');
  var confirmPasswordController = TextEditingController(text: '1234567');
  var keyForm = GlobalKey<FormState>();

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
                    controller: textController,
                    label: 'User Name',
                    vaildator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter User Name';
                      }

                      return null;
                    },
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
                  CustomTextFormField(
                    controller: confirmPasswordController,
                    label: 'Confirm Password',
                    isPassword: true,
                    vaildator: (confirmPassword) {
                      if (confirmPassword == null ||
                          confirmPassword.trim().isEmpty) {
                        return 'Please Enter User ConfirmPassword';
                      }

                      if (confirmPassword != passwordController.text) {
                        return 'the password doesnot match';
                      }

                      return null;
                    },
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      onPressed: () async {
                        if (keyForm.currentState!.validate()) {
                          // add account;
                          DialogUtils.showLoading(context);
                          try {
                            final userCredential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            MyUserModel user = MyUserModel(
                                email: emailController.text,
                                id: userCredential.user?.uid ?? "",
                                name: textController.text);
                            await FirestoreLogic.addUserToFireStore(user);
                            var authProvider =
                                Provider.of<AuthenticationProvider>(context,
                                    listen: false);
                            authProvider.updateUser(user);
                            DialogUtils.closeLoading(context);
                            DialogUtils.showMessage(
                              context,
                              message: 'Successfull Register',
                              posActionTitle: 'okay',
                              posAction: () {
                                Navigator.pushReplacementNamed(context, HomeView.id);
                              },
                            );
                          } on FirebaseAuthException catch (e) {
                            DialogUtils.closeLoading(context);
                            if (e.code == 'weak-password') {
                              DialogUtils.showMessage(context,
                                  posActionTitle: 'okay',
                                  message:
                                      'The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              DialogUtils.showMessage(context,
                                  posActionTitle: 'okay',
                                  message:
                                      'The account already exists for that email.');
                            }
                          } catch (e) {
                            DialogUtils.closeLoading(context);
                            DialogUtils.showMessage(context,
                                posActionTitle: 'okay', message: e.toString());
                          }
                        }
                      },
                      child: Text(
                        "Register",
                        style: Theme.of(context).textTheme.titleLarge,
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already Have Account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Login In ",
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
