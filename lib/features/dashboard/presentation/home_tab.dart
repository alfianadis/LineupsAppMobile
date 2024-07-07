import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lineups/features/aspek/presentation/aspek_screen.dart';
import 'package:lineups/features/dashboard/presentation/home_secreen.dart';
import 'package:lineups/features/kriteria/presentation/kriteria_screen.dart';
import 'package:lineups/features/lineup/presentation/lineup_screen.dart';
import 'package:lineups/features/penilaian/presentation/penilaian_screen.dart';
import 'package:lineups/features/player/presentation/player_screen.dart';
import 'package:lineups/utils/asset_path.dart';
import 'package:lineups/utils/colors.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    super.dispose();
  }

  late TabController controller;
  int _currentIndex = 0;

  final List<Widget> _children = [
    const HomeScreen(),
    const PlayerScreen(),
    // const AspekScreen(),
    const LineupScreen(),
    // const KriteriaScreen(),
    // const PenilaianScreen()
  ];

  @override
  void initState() {
    super.initState();

    controller = TabController(
      vsync: this,
      length: 3,
    );
  }

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 65,
        width: 310,
        margin: const EdgeInsets.only(right: 25, left: 25, bottom: 25),
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              //home
              BottomNavigationBarItem(
                icon: Image.asset(
                  AssetPath.icHome,
                  width: 20,
                  color: _currentIndex == 0
                      ? AppColors.bgColor
                      : AppColors.greyColor,
                ),
                label: 'Home',
              ),
              //player
              BottomNavigationBarItem(
                icon: Image.asset(
                  AssetPath.playeruniform,
                  width: 20,
                  color: _currentIndex == 1
                      ? AppColors.bgColor
                      : AppColors.greyColor,
                ),
                label: 'Pemain',
              ),
              //lineup
              BottomNavigationBarItem(
                icon: Image.asset(
                  AssetPath.lineup,
                  width: 20,
                  color: _currentIndex == 2
                      ? AppColors.bgColor
                      : AppColors.greyColor,
                ),
                label: 'Line Up',
              ),
              // BottomNavigationBarItem(
              //   icon: Image.asset(
              //     AssetPath.icOrder,
              //     width: 20,
              //     color: _currentIndex == 3
              //         ? AppColors.bgColor
              //         : AppColors.greyColor,
              //   ),
              //   label: 'Kriteria',
              // ),
              // BottomNavigationBarItem(
              //   icon: Image.asset(
              //     AssetPath.icOrder,
              //     width: 20,
              //     color: _currentIndex == 4
              //         ? AppColors.bgColor
              //         : AppColors.greyColor,
              //   ),
              //   label: 'Penilaian',
              // ),
            ],
            currentIndex: _currentIndex,
            onTap: onTappedBar,
            iconSize: 28,
            selectedLabelStyle: const TextStyle(
                color: AppColors.bgColor), // Gaya teks saat dipilih
            unselectedLabelStyle: const TextStyle(color: AppColors.greyColor),
            showSelectedLabels: true, // Untuk memastikan label selalu terlihat
            showUnselectedLabels: true,
            selectedItemColor:
                AppColors.bgColor, // Warna teks label saat item aktif
            unselectedItemColor:
                AppColors.greyColor, // Warna teks label saat item tidak aktif
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
      body: _children[_currentIndex],
    );
  }
}
