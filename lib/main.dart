import 'package:flutter/material.dart';
import 'package:go_rent/provider/auth_provider.dart';
import 'package:go_rent/views/pages/auth/login.dart';
import 'package:go_rent/views/pages/auth/register.dart';
import 'package:go_rent/views/pages/edit_profile.dart';
import 'package:go_rent/views/pages/home/detail_page.dart';
import 'package:go_rent/views/pages/home/main_page.dart';
import 'package:go_rent/views/pages/payment/checkout_screen.dart';
import 'package:go_rent/views/pages/payment/payment_screen.dart';
import 'package:go_rent/views/pages/splash_screen.dart';
import 'package:go_rent/views/themes/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}
// 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Go-Rent',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(textTheme),
          backgroundColor: lightColor,
        ),
        home: const SplashScreenPage(),
        routes: {
          'login': (context) => const LoginPage(),
          'register': (context) => const RegisterPage(),
          'home': (context) => const MainPage(),
          'edit-profile': (context) => const EditProfilePage(),
          'detail-page': (context) => DetailPage(),
          'checkout': (context) => CheckoutScreen(),
          'payment': (context) => PaymentScreen(),
        },
      ),
    );
  }
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  counter() {
    int count = 0;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(counter()),
              Builder(builder: (context) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                  ),
                  onPressed: () => counter(),
                  child: const Text("Save"),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
