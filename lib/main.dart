import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lineups/config/user_provider.dart';
import 'package:lineups/features/login/data/models/auth_response.dart';
import 'package:lineups/features/login/presentation/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Periksa status login
  final prefs = await SharedPreferences.getInstance();
  final userJson = prefs.getString('user');
  User? user;

  if (userJson != null) {
    user = User.fromJson(jsonDecode(userJson));
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MyApp(initialUser: user),
    ),
  );
}

class MyApp extends StatelessWidget {
  final User? initialUser;
  const MyApp({super.key, this.initialUser});

  @override
  Widget build(BuildContext context) {
    if (initialUser != null) {
      Provider.of<UserProvider>(context, listen: false).setUser(initialUser!);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mini Project",
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id'), // Bahasa Indonesia
      ],
      home: const SplashScreen(),
    );
  }
}
