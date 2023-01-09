import 'package:flutter/material.dart';
import 'package:go_rent/provider/auth_provider.dart';
import 'package:go_rent/services/auth_service.dart';
import 'package:go_rent/views/pages/auth/login.dart';
import 'package:go_rent/views/themes/colors.dart';
import 'package:go_rent/views/themes/font_weights.dart';
import 'package:go_rent/views/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;
  bool showPassword = false;

  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController noHpController = TextEditingController(text: '');
  TextEditingController alamatController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  void saveLoginStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("email", emailController.text);
    pref.setString("password", passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    int? register;
    Future<void> doRegister() async {
      setState(() {
        isLoading = true;
      });

      register = await AuthService().register(
          username: usernameController.text,
          noHp: noHpController.text,
          email: emailController.text,
          alamat: alamatController.text,
          password: passwordController.text);

      print(register);
      if (register == 201) {
        // saveLoginStatus();
        // Navigator.pushReplacementNamed(context, 'home');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (Route<dynamic> route) => false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: greenColor,
            content: Text(
              'Berhasil register',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: alertColor,
            content: Text(
              'Email sudah terdaftar',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      // if (await authProvider.register(
      //     username: usernameController.text,
      //     noHp: noHpController.text,
      //     email: emailController.text,
      //     alamat: alamatController.text,
      //     password: passwordController.text)) {
      //   saveLoginStatus();

      //   Navigator.pushReplacementNamed(context, 'home');
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       backgroundColor: greenColor,
      //       content: Text(
      //         'Berhasil register',
      //         textAlign: TextAlign.center,
      //       ),
      //     ),
      //   );
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       backgroundColor: alertColor,
      //       content: Text(
      //         'Email sudah terdaftar',
      //         textAlign: TextAlign.center,
      //       ),
      //     ),
      //   );
      // }

      setState(() {
        isLoading = false;
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_circle_left_outlined,
                      size: 36.0,
                    ),
                    onPressed: () => Navigator.pop(context),
                    color: primaryColor,
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Daftar",
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),

              // INPUT NAMA
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: semibold,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      autofocus: true,
                      controller: usernameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "your name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),

              // INPUT EMAIL
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: semibold,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "email@contoh.com",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),

              // INPUT NO HP
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nomor Telepon",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: semibold,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: noHpController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "your phone number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),

              // INPUT ADDRESS
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Alamat",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: semibold,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: alamatController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "your address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),

              // INPUT PASSWORD
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: semibold,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: !showPassword,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            showPassword = !showPassword;
                            setState(() {});
                          },
                          icon: Icon(
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 24.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "your password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),

              // BUTTON
              isLoading
                  ? const LoadingWidget()
                  : Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 40.0),
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
                          onPressed: () => doRegister(),
                          child: const Text("Daftar"),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Sudah punya akun ? '),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, 'login'),
                    child: Text(
                      "Login yuk",
                      style: TextStyle(fontWeight: bold, color: greenColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
