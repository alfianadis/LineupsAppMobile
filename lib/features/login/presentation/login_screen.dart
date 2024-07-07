import 'package:flutter/material.dart';
import 'package:lineups/features/dashboard/presentation/home_secreen.dart';
import 'package:lineups/features/register/presentation/register_screen.dart';
import 'package:lineups/utils/colors.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool obscureText = false;
  bool isLoading = false;
  bool isActive = false;

  String? username;
  String? password;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text('Selamat Datang'),
            const SizedBox(height: 40),
            FormBuilder(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormBuilderTextField(
                      cursorColor: AppColors.neutralColor,
                      // ignore: unnecessary_null_in_if_null_operators
                      initialValue: username ?? null,
                      onChanged: (val) {
                        setState(() {
                          username = val;
                        });
                      },
                      name: 'username',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 23.0, horizontal: 20.0),
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        label: const Text(
                          'Enter Username',
                          style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 10,
                              color: AppColors.greySixColor),
                        ),
                        filled: true,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.neutralColor,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.greenSecobdColor,
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                        ),
                        fillColor: AppColors.greenSecobdColor,
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormBuilderTextField(
                      // ignore: unnecessary_null_in_if_null_operators
                      cursorColor: AppColors.neutralColor,
                      initialValue: password,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      obscureText: obscureText ? false : true,
                      name: 'password',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 23.0, horizontal: 20.0),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() => obscureText = !obscureText);
                          },
                          icon: obscureText
                              ? SvgPicture.asset(
                                  "assets/icons/eye.svg",
                                  // ignore: deprecated_member_use
                                  color: AppColors.neutralColor,
                                )
                              : SvgPicture.asset(
                                  "assets/icons/eye-slash.svg",
                                  // ignore: deprecated_member_use
                                  color: AppColors.neutralColor,
                                ),
                        ),
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        label: const Text(
                          'Enter Password',
                          style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 10,
                              color: AppColors.greySixColor),
                        ),
                        filled: true,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.neutralColor,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.greenSecobdColor,
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                        ),
                        fillColor: AppColors.greenSecobdColor,
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(4, errorText: 'lorep'),
                      ]),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
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
                              'Sign In',
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
                              'Register',
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
              ),
            ),
          ],
        ),
      )),
    );
  }
}
