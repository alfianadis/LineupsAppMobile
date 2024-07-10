import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lineups/service/api_service.dart';
import 'package:lineups/utils/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();

  String selectedRole = '';

  bool obscureText = true;
  bool obscureCText = true;

  final ApiService apiService = ApiService();

  Future<void> _register() async {
    if (_usernameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty ||
        _fullNameController.text.isEmpty ||
        selectedRole.isEmpty) {
      _showDialog('Error', 'Semua data harus diisi');
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showDialog('Error', 'Password dan Konfirmasi Password tidak sama');
      return;
    }

    try {
      await apiService.register(
        _usernameController.text,
        _passwordController.text,
        _fullNameController.text,
        selectedRole,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Berhasil mendaftar')),
      );
      Navigator.pop(context);
    } catch (e) {
      _showDialog('Error', e.toString());
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                      'Nama lengkap',
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
                          controller: _fullNameController,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Masukkan Nama Lengkap Anda*",
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
                      'Pilih Role',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        // Menampilkan modal bottom sheet ketika InkWell diklik
                        await _showModalBottomRole(context, size);
                      },
                      child: Container(
                        height: size.height * 0.09,
                        width: size.width,
                        padding: const EdgeInsets.only(left: 20, right: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.greenSecobdColor,
                          border: Border.all(
                            color: AppColors.greySecondColor,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width * 0.62,
                              child: Text(
                                selectedRole.isNotEmpty
                                    ? selectedRole
                                    : 'Pilih Role',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: selectedRole.isNotEmpty
                                      ? FontWeight.bold
                                      : FontWeight.w200,
                                  color: selectedRole.isNotEmpty
                                      ? AppColors.neutralColor
                                      : AppColors.greySixColor,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            selectedRole.isNotEmpty
                                ? InkWell(
                                    onTap: () {
                                      // Reset nilai aspek yang dipilih
                                      setState(() {
                                        selectedRole = '';
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      'assets/icons/cross.svg',
                                      width: 20,
                                      height: 20,
                                      color: AppColors.neutralColor,
                                    ),
                                  )
                                : SvgPicture.asset(
                                    'assets/icons/arrow-down.svg',
                                    width: 15,
                                    height: 15,
                                    color: AppColors.neutralColor,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 20),
                    const Text(
                      'Konfirmasi Password',
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
                          controller: _confirmPasswordController,
                          obscureText: obscureCText,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Masukkan Kembali Password Anda*",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 12,
                                color: AppColors.greySixColor),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureCText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureCText = !obscureCText;
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
                          onTap: _register,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showModalBottomRole(BuildContext context, Size size) {
    // Contoh sumber data aspek (gantilah dengan sumber data yang sesuai)
    List<String> listPosisi = ['Pelatih', 'Asisten Pelatih', 'Pemain'];

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: size.height * 0.8),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              width: size.width,
              height: size.height * 0.75,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/shape.svg',
                        width: 10,
                        height: 5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Pilih Role',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      // ListView.builder untuk membuat daftar aspek
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: listPosisi.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              // Memperbarui state dan menutup modal bottom sheet ketika aspek dipilih
                              setState(() {
                                selectedRole = listPosisi[index];
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: size.height * 0.08,
                              width: size.width,
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: AppColors.greyTreeColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, top: 20),
                                child: Text(
                                  listPosisi[index],
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).then((value) {
      // Memperbarui tampilan InkWell setelah modal bottom sheet tertutup
      setState(() {});
    });
  }
}
