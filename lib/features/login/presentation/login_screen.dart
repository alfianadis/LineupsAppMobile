import 'package:flutter/material.dart';
import 'package:lineups/config/user_provider.dart';
import 'package:lineups/features/dashboard/presentation/home_tab.dart';
import 'package:lineups/features/login/data/models/auth_response.dart';
import 'package:lineups/features/register/presentation/register_screen.dart';
import 'package:lineups/service/api_service.dart';
import 'package:lineups/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool obscureText = true;
  bool isLoading = false;

  final ApiService apiService = ApiService();

  Future<void> _login() async {
    try {
      AuthResponse response = await apiService.login(
        context,
        _usernameController.text,
        _passwordController.text,
      );

      // Simpan token atau lakukan tindakan lain dengan response.accessToken
      print('Login successful: ${response.accessToken}');

      // Update UserProvider
      Provider.of<UserProvider>(context, listen: false).setUser(response.user);

      // Menampilkan dialog sukses dan navigasi ke MainScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeTab(),
        ),
      );
    } catch (e) {
      // Menampilkan dialog gagal
      print('Login failed with error: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 40),
            child: Column(
              children: [
                const Text(
                  'Selamat Datang',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Username',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: size.height * 0.09,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: AppColors.greenSecobdColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25, top: 8),
                        child: TextFormField(
                          controller: _usernameController,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Masukkan Username Anda*",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 12,
                                color: AppColors.greySixColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: size.height * 0.09,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: AppColors.greenSecobdColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25, top: 8),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: obscureText,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Masukkan Password Anda*",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 12,
                                color: AppColors.greySixColor),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Container(
                        width: size.width * 0.8,
                        height: size.height * 0.07,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black,
                        ),
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: isLoading ? null : _login,
                          child: Center(
                            child: isLoading
                                ? CircularProgressIndicator(
                                    color: AppColors.whiteTextColor,
                                  )
                                : const Text(
                                    'Masuk',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: AppColors.whiteTextColor),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Center(
                      child: Container(
                        width: size.width * 0.8,
                        height: size.height * 0.07,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.greyFourColor,
                        ),
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: const Center(
                            child: Text(
                              'Daftar',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
