import 'package:flutter/material.dart';
import 'package:go_rent/models/user_model.dart';
import 'package:go_rent/provider/auth_provider.dart';
import 'package:go_rent/views/themes/colors.dart';
import 'package:go_rent/views/themes/font_weights.dart';
import 'package:go_rent/views/widgets/loading.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    TextEditingController usernameController =
        TextEditingController(text: user.username!);
    TextEditingController noHpController =
        TextEditingController(text: user.noHp!);
    TextEditingController alamatController =
        TextEditingController(text: user.alamat!);

    Future<void> updateBiodata() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.update(
          idUser: user.idUser!,
          username: usernameController.text,
          noHp: noHpController.text,
          alamat: alamatController.text)) {
        Navigator.pushReplacementNamed(context, 'home');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: greenColor,
            content: Text(
              'Data berhasil diperbarui',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: alertColor,
            content: Text(
              'Data wajib diisi!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget header() {
      return Container(
        height: 100.0,
        padding: const EdgeInsets.only(top: 25.0, left: 20.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          color: primaryColor,
        ),
        child: Row(
          children: [
            Text(
              "Perbarui Profil",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: semibold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    Widget valueData(
      String label,
      TextEditingController value,
    ) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          controller: value,
          maxLength: 100,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              color: primaryColor,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
              ),
            ),
          ),
          onChanged: (value) {},
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
            height: 30.0,
          ),
          valueData('Username Pengguna', usernameController),
          valueData('Nomor Telepon', noHpController),
          valueData('Alamat', alamatController),
          const SizedBox(
            height: 40.0,
          ),
          isLoading
              ? const LoadingWidget()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      icon: const Icon(Icons.close),
                      label: const Text("Batal"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryColor,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.check),
                      label: const Text("Simpan"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () => updateBiodata(),
                    ),
                  ],
                )
        ],
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            body(),
          ],
        ),
      ),
    );
  }
}
