import 'package:flutter/material.dart';
import 'package:lineups/features/dashboard/presentation/home_tab.dart';
import 'package:lineups/utils/colors.dart';

class LineupScreen extends StatefulWidget {
  const LineupScreen({super.key});

  @override
  State<LineupScreen> createState() => _LineupScreenState();
}

class _LineupScreenState extends State<LineupScreen> {
  final List<Player> players = [
    Player(image: 'assets/images/albagir.jpg', top: 0.1, left: 0.38),
    Player(image: 'assets/images/iqbal.jpg', top: 0.28, left: 0.38),
    Player(image: 'assets/images/ancha.jpg', top: 0.45, left: 0.6),
    Player(image: 'assets/images/runtuboy.jpg', top: 0.45, left: 0.15),
    Player(image: 'assets/images/ais.jpg', top: 0.6, left: 0.38),
    // Player(image: 'assets/player6.png', top: 0.5, left: 0.5),
    // Player(image: 'assets/player7.png', top: 0.5, left: 0.7),
    // Player(image: 'assets/player8.png', top: 0.7, left: 0.3),
    // Player(image: 'assets/player9.png', top: 0.7, left: 0.5),
    // Player(image: 'assets/player10.png', top: 0.9, left: 0.4),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HomeTab(),
                ),
              );
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 23,
              color: AppColors.neutralColor,
            ),
          ),
          title: const Text(
            'Line Up Pemain',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Container(
                  height: size.height * 0.6,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/lineup_board.png',
                        fit: BoxFit.cover,
                        width: size.width,
                        height: size.height * 0.6,
                      ),
                      ...players.map((player) {
                        return Positioned(
                          top: player.top * size.height * 0.6,
                          left: player.left * size.width,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(player.image),
                            radius: 30,
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class Player {
  final String image;
  final double top;
  final double left;

  Player({required this.image, required this.top, required this.left});
}
