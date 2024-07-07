import 'package:flutter/material.dart';
import 'package:lineups/features/penilaian/presentation/hasil_penilaian_screen.dart';
import 'package:lineups/utils/colors.dart';

class SplashSuccessSpk extends StatefulWidget {
  const SplashSuccessSpk({super.key});

  @override
  State<SplashSuccessSpk> createState() => _SplashSuccessSpkState();
}

class _SplashSuccessSpkState extends State<SplashSuccessSpk> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ResultSPKScreen()),
      );
    });
    return Scaffold(
      body: Container(
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(
        //       "assets/images/success-background.png",
        //     ),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.4),
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'Data Berhasil Di Simpan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {},
              child: Container(
                height: size.height * 0.06,
                width: size.width * 0.5,
                decoration: const BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Lanjutkan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.1),
          ],
        ),
      ),
    );
  }
}
