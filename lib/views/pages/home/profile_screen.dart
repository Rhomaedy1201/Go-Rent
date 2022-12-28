import 'package:flutter/material.dart';
import 'package:go_rent/models/user_model.dart';
import 'package:go_rent/provider/auth_provider.dart';
import 'package:go_rent/views/themes/colors.dart';
import 'package:go_rent/views/themes/font_weights.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    Widget header() {
      return Container(
        height: 100.0,
        padding: const EdgeInsets.only(top: 25.0, left: 20.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          color: primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Profil",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: semibold,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () async {
                bool confirm = false;
                await showDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Konfirmasi'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Apakah Anda yakin ingin logout?'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[600],
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Kembali"),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                          onPressed: () {
                            confirm = true;
                            Navigator.pop(context);
                          },
                          child: const Text("Iya"),
                        ),
                      ],
                    );
                  },
                );

                if (confirm) {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.setString("email", '');
                  pref.setString("password", '');

                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: greenColor,
                      content: Text(
                        'Berhasil logout',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
              icon: const Icon(
                Icons.logout,
                color: alertColor,
                size: 24.0,
              ),
            ),
          ],
        ),
      );
    }

    Widget valueData(
      String label,
      String value,
    ) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Text(
              label,
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: semibold,
              ),
            ),
          ],
        ),
      );
    }

    Widget body() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30.0,
          ),
          Center(
            child: Image.network(
              "https://ui-avatars.com/api/?name=${user.username}&color=7F9CF5&background=random&rounded=true&size=200",
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          valueData('Username Pengguna', user.username!),
          valueData('Email', user.email!),
          valueData('Nomor Telepon', user.noHp!),
          valueData('Alamat', user.alamat!),
          const SizedBox(
            height: 40.0,
          ),
          Center(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text("Perbarui Profil"),
              style: OutlinedButton.styleFrom(
                foregroundColor: primaryColor,
                shape: const StadiumBorder(),
              ),
              onPressed: () => Navigator.pushNamed(context, 'edit-profile'),
            ),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(),
          body(),
        ],
      ),
    );
  }
}
