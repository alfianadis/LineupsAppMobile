// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:lineups/features/aspek/data/models/aspek_model.dart';
import 'package:lineups/service/api_service.dart';
import 'package:lineups/splash_success.dart';
import 'package:lineups/utils/colors.dart';

class AddAspekkScreen extends StatefulWidget {
  const AddAspekkScreen({super.key});

  @override
  State<AddAspekkScreen> createState() => _AddAspekkScreenState();
}

class _AddAspekkScreenState extends State<AddAspekkScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _coreFactorController = TextEditingController();
  TextEditingController _secondaryFactorController = TextEditingController();

  ApiService _apiService = ApiService();

  void _addAspek() async {
    String name = _nameController.text.trim();
    int coreFactor = int.tryParse(_coreFactorController.text.trim()) ?? 0;
    int secondaryFactor =
        int.tryParse(_secondaryFactorController.text.trim()) ?? 0;

    if (name.isNotEmpty) {
      AspekModel newAspek = AspekModel(
        id: '', // ID akan diisi oleh server, jadi biarkan kosong
        assessmentAspect: name,
        coreFactor: coreFactor,
        secondaryFactor: secondaryFactor,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        v: 0,
      );

      try {
        // Memanggil metode untuk menambahkan aspek baru
        // ignore: unused_local_variable
        AspekModel addedAspek = await _apiService.createAspekModel(newAspek);

        // Tampilkan pesan sukses atau navigasi ke layar splash success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aspek berhasil ditambahkan')),
        );

        // Navigasi ke halaman splash success setelah menambahkan berhasil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SplashSuccess()),
        );
      } catch (e) {
        // Tangani error saat gagal menambahkan aspek
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menambahkan aspek: $e')),
        );
      }
    } else {
      // Tampilkan pesan jika input tidak valid
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Peringatan'),
          content: Text('Harap lengkapi semua informasi yang diperlukan.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 23,
            color: AppColors.neutralColor,
          ),
        ),
        title: const Text(
          'Tambah Aspek',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Aspek Penilaian',
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
                    controller: _nameController,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Masukkan Aspek*",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 12,
                          color: AppColors.greySixColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Core Factor',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: size.height * 0.09,
                        width: size.width * 0.4,
                        decoration: BoxDecoration(
                          color: AppColors.greenSecobdColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25, top: 8),
                          child: TextFormField(
                            controller: _coreFactorController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "0",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 12,
                                  color: AppColors.greySixColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Secondary Factor',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: size.height * 0.09,
                        width: size.width * 0.4,
                        decoration: BoxDecoration(
                          color: AppColors.greenSecobdColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25, top: 8),
                          child: TextFormField(
                            controller: _secondaryFactorController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "0",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 12,
                                  color: AppColors.greySixColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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
                    onTap:
                        _addAspek, // Panggil method _addAspek saat tombol ditekan
                    child: const Center(
                      child: Text(
                        'Tambah Aspek',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: AppColors.whiteTextColor),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
