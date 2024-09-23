import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constant.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/email_text_form_field.dart';
import '../widgets/pass_text_form_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static const id = 'register view';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(height: height * 0.0525),
                  SizedBox(
                      width: width * 0.255,
                      height: height * 0.131,
                      child: Image.asset('assets/images/logo.png')),
                  SizedBox(height: height * 0.0328),
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(color: Colors.black, fontSize: 36),
                  ),
                  SizedBox(height: height * 0.1),
                  const Row(
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(color: Colors.black, fontSize: 28),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.0197),
                  EmailTextFormField(
                    hintText: 'Email',
                    onChange: (data) => email = data,
                  ),
                  SizedBox(height: height * 0.0197),
                  PasswordTextFormField(
                    hintText: 'Password',
                    onChange: (data) => password = data,
                  ),
                  SizedBox(height: height * 0.0197),
                  CustomButton(
                    text: 'REGISTER',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await signUpUser();
                          if (context.mounted) {
                            snackBarMsg(context, 'Signed up successfully');
                            Navigator.pop(context);
                          }
                        } on FirebaseAuthException catch (e) {
                          isLoading = false;
                          setState(() {});
                          if (e.code == 'weak-password') {
                            if (context.mounted) {
                              snackBarMsg(context,
                                  'The password provided is too weak.');
                            }
                          } else if (e.code == 'email-already-in-use') {
                            if (context.mounted) {
                              snackBarMsg(context,
                                  'The account already exists for that email.');
                            }
                          } else if (e.code == 'invalid-email') {
                            if (context.mounted) {
                              snackBarMsg(context,
                                  'The email is badly formatted, please add domain ex: user@email.com .');
                            }
                          }
                        } catch (e) {
                          isLoading = false;
                          setState(() {});

                          if (context.mounted) {
                            snackBarMsg(context,
                                'There was an error please try again later.');
                          }
                        }
                        isLoading = false;
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(height: height * 0.0197),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        width: width * 0.0191,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUpUser() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
