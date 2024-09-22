import 'dart:async';

import 'package:flutter/material.dart';
import 'package:storeapp/views/signin_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static String id = 'splash view';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5),
        () => Navigator.of(context).pushReplacementNamed(SigninView.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white,Colors.white],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset('assets/images/logo.png')],
        ),
      ),
    );
  }
}
