import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/firebase_options.dart';
import 'views/add_product_view.dart';
import 'views/cart_view.dart';
import 'views/home_view.dart';
import 'views/register_view.dart';
import 'views/signin_view.dart';
import 'views/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const StoreApp());
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SigninView.id: (context) => const SigninView(),
        RegisterView.id: (context) => const RegisterView(),
        SplashView.id: (context) => const SplashView(),
        HomeView.id: (context) => const HomeView(),
        AddProductView.id: (context) => const AddProductView(),
        CartView.id: (context) => const CartView(),
      },
      initialRoute: SplashView.id,
    );
  }
}
