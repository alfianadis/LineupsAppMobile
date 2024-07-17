import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lineups/features/dashboard/presentation/home_tab.dart';
import 'package:lineups/features/login/data/models/auth_response.dart';
import 'package:lineups/features/login/presentation/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lineups/config/user_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 5)); // Menambahkan delay 5 detik
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      // Jika pengguna sudah login, arahkan ke HomeTab
      final user = User.fromJson(jsonDecode(userJson));
      Provider.of<UserProvider>(context, listen: false).setUser(user);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeTab(),
        ),
      );
    } else {
      // Jika pengguna belum login, arahkan ke LoginScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Image.asset("assets/images/logo_white.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
