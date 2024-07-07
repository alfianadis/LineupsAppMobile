import 'package:flutter/material.dart';
import 'package:lineups/features/login/presentation/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mini Project",
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: const SplashScreen(),
      // onGenerateRoute: RouteConfig.onGenerateRoute,
    );
  }
}
