import 'package:flutter/material.dart';
import 'package:go_rent/provider/auth_provider.dart';
import 'package:go_rent/views/themes/colors.dart';
import 'package:go_rent/views/themes/images.dart';
import 'package:go_rent/views/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  bool isLoading = false;
  String? getEmail, getPassword;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    Future<void> handleAutomaticLogin() async {
      setState(() {
        isLoading = true;
      });

      SharedPreferences pref = await SharedPreferences.getInstance();
      getEmail = pref.getString("email") ?? '';
      getPassword = pref.getString("password") ?? '';

      if (await authProvider.login(
        email: getEmail!,
        password: getPassword!,
      )) {
        Navigator.pushReplacementNamed(context, 'home');
      } else {
        Navigator.pushNamed(context, 'login');
      }

      setState(() {
        isLoading = false;
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                logo,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
              const Text(
                "Go - Rent",
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 100.0,
              ),
              const Text(
                "Panik tidak ada kendaraan ?\nTenang sewa saja kendaraan disini",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              isLoading
                  ? const LoadingWidget()
                  : SizedBox(
                      width: 200.0,
                      height: 50.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                        onPressed: () => handleAutomaticLogin(),
                        child: const Text("Login"),
                      ),
                    ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: 200.0,
                height: 50.0,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, 'register'),
                  child: const Text("Daftar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
