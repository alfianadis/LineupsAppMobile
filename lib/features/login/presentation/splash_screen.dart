import 'package:flutter/material.dart';
import 'package:lineups/features/dashboard/presentation/home_secreen.dart';
import 'package:lineups/features/dashboard/presentation/home_tab.dart';
import 'package:lineups/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goToHomeScreen();
    super.initState();
  }

  void goToHomeScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeTab(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

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
                  child: Image.asset("assets/images/logo_white.png")),
            ],
          ),
        ),
      ),
    );
  }
}
