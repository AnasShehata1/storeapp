import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:storeapp/views/home_view.dart';
import 'package:storeapp/views/register_view.dart';
import '../constant.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/email_text_form_field.dart';
import '../widgets/pass_text_form_field.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});
  static const id = 'signin view';

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Form(
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
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  SizedBox(height: height * 0.0328),
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(color: Colors.black, fontSize: 36),
                  ),
                  SizedBox(height: height * 0.1),
                  const Row(
                    children: [
                      Text(
                        'Sign In',
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
                  SizedBox(height: height * 0.0262),
                  CustomButton(
                    text: 'SIGN IN',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await signInUser();
                          if (context.mounted) {
                            snackBarMsg(context, 'Signed in successfully');
                            Navigator.of(context).pushReplacementNamed(
                                HomeView.id,
                                arguments: email);
                          }
                        } on FirebaseAuthException catch (e) {
                          isLoading = false;
                          setState(() {});
                          if (e.code == 'user-not-found') {
                            if (context.mounted) {
                              snackBarMsg(
                                  context, 'No user found for that email.');
                            }
                          } else if (e.code == 'wrong-password') {
                            if (context.mounted) {
                              snackBarMsg(context,
                                  'Wrong password provided for that user.');
                            }
                          } else if (e.code == 'invalid-email') {
                            if (context.mounted) {
                              snackBarMsg(context,
                                  'The email is badly formatted, please add domain ex: user@email.com.');
                            }
                          } else if (e.code == 'invalid-credential') {
                            if (context.mounted) {
                              snackBarMsg(context,
                                  'Email not found or wrong password.');
                            }
                          } else {
                            if (context.mounted) {
                              snackBarMsg(context,
                                  'There was an error please try again later.');
                            }
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
                        'Don\'t have an account?',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        width: width * 0.0191,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(RegisterView.id);
                        },
                        child: const Text(
                          'Register',
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

  Future<void> signInUser() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
    FirebaseFirestore.instance.collection(email!);
  }
}
