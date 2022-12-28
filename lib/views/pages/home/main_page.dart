import 'package:flutter/material.dart';
import 'package:go_rent/provider/auth_provider.dart';
import 'package:go_rent/views/pages/home/history_screen.dart';
import 'package:go_rent/views/pages/home/home_screen.dart';
import 'package:go_rent/views/pages/home/profile_screen.dart';
import 'package:go_rent/views/themes/colors.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    Widget body() {
      switch (currentIndex) {
        case 0:
          return const HomeScreen();
        case 1:
          return HistoryScreen(authProvider.user);
        case 2:
          return const ProfileScreen();
        default:
          return const HomeScreen();
      }
    }

    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
        child: SizedBox(
          height: 80.0,
          child: BottomAppBar(
            child: BottomNavigationBar(
              backgroundColor: primaryColor,
              selectedItemColor: greenColor,
              unselectedItemColor: Colors.white,
              currentIndex: currentIndex,
              onTap: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 24.0,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.history,
                    size: 24.0,
                  ),
                  label: 'History',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 24.0,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
