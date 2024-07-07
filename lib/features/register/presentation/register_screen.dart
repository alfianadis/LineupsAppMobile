import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lineups/features/dashboard/presentation/home_secreen.dart';
import 'package:lineups/utils/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool obscureText = false;
  bool obscureCText = false;
  String? _errorPassText;
  String? _errorPassCText;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          children: [
            const SizedBox(height: 40.0),
            const Text('Buat Akun Anda '),
            const SizedBox(height: 40),
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
                  controller: _emailController,
                  onChanged: (value) {},
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Username*",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 12,
                        color: AppColors.greySixColor),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              height: size.height * 0.09,
              width: size.width,
              decoration: BoxDecoration(
                color: AppColors.greenSecobdColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 25, top: 5),
                child: TextFormField(
                  controller: _passwordController,
                  onChanged: (value) {},
                  validator: (value) {
                    // _validateInput(value!);
                    return null;
                  },
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  obscureText: obscureText ? false : true,
                  decoration: InputDecoration(
                    contentPadding: _errorPassText != null
                        ? EdgeInsets.only(top: size.height * 0.02)
                        : EdgeInsets.only(top: size.height * 0.024),
                    // errorText: _errorPassText,
                    border: InputBorder.none,
                    hintText: "Kata Sandi*",
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 12,
                        color: AppColors.greySixColor),
                    errorStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    suffixIcon: Padding(
                      padding: _errorPassText != null
                          ? const EdgeInsets.only(top: 14)
                          : const EdgeInsets.only(top: 4),
                      child: IconButton(
                        onPressed: () {
                          setState(() => obscureText = !obscureText);
                        },
                        icon: obscureText
                            ? SvgPicture.asset(
                                "assets/icons/eye.svg",
                                // ignore: deprecated_member_use
                                color: AppColors.greyFourColor,
                              )
                            : SvgPicture.asset(
                                "assets/icons/eye-slash.svg",
                                // ignore: deprecated_member_use
                                color: AppColors.greyFourColor,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              height: size.height * 0.09,
              width: size.width,
              decoration: BoxDecoration(
                color: AppColors.greenSecobdColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 25, top: 5),
                child: TextFormField(
                  controller: _confirmPasswordController,
                  onChanged: (value) {},
                  validator: (value) {
                    // _validateInput(value!);
                    return null;
                  },
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  obscureText: obscureCText ? false : true,
                  decoration: InputDecoration(
                    contentPadding: _errorPassText != null
                        ? EdgeInsets.only(top: size.height * 0.02)
                        : EdgeInsets.only(top: size.height * 0.024),
                    // errorText: _errorPassText,
                    border: InputBorder.none,
                    hintText: "Konfirmasi Kata Sandi*",
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 12,
                        color: AppColors.greySixColor),
                    errorStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    suffixIcon: Padding(
                      padding: _errorPassCText != null
                          ? const EdgeInsets.only(top: 14)
                          : const EdgeInsets.only(top: 4),
                      child: IconButton(
                        onPressed: () {
                          setState(() => obscureCText = !obscureCText);
                        },
                        icon: obscureText
                            ? SvgPicture.asset(
                                "assets/icons/eye.svg",
                                // ignore: deprecated_member_use
                                color: AppColors.greyFourColor,
                              )
                            : SvgPicture.asset(
                                "assets/icons/eye-slash.svg",
                                // ignore: deprecated_member_use
                                color: AppColors.greyFourColor,
                              ),
                      ),
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Center(
                    child: Text(
                      'Sign Up',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sudah punya akun?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(
                  onPressed: (() {
                    Navigator.of(context).pop();
                  }),
                  child: const Text(
                    "Masuk",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greenColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
          ],
        ),
      )),
    );
  }
}
