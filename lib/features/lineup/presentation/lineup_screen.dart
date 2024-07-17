import 'package:flutter/material.dart';
import 'package:lineups/features/dashboard/presentation/home_tab.dart';
import 'package:lineups/features/penilaian/data/models/assesment_model.dart';
import 'package:lineups/service/api_service.dart';
import 'package:lineups/utils/colors.dart';

class LineupScreen extends StatefulWidget {
  const LineupScreen({super.key});

  @override
  State<LineupScreen> createState() => _LineupScreenState();
}

class _LineupScreenState extends State<LineupScreen> {
  List<AssessmentModel> _assessments = [];
  final ApiService apiService = ApiService();

  List<Player> players = [];
  List<Player> substitutePlayers = [];

  @override
  void initState() {
    super.initState();
    _fetchPlayers();
  }

  Future<void> _fetchPlayers() async {
    try {
      List<AssessmentModel> data = await apiService.fetchPlayerData();
      setState(() {
        _assessments = data;
        _setBestPlayers();
      });
    } catch (e) {
      print('Failed to load data: $e');
    }
  }

  void _setBestPlayers() {
    List<AssessmentModel> anchorPlayers =
        _getBestPlayersByPosition('Anchor', 1);
    List<AssessmentModel> pivotPlayers = _getBestPlayersByPosition('Pivot', 1);
    List<AssessmentModel> flankPlayers = _getBestPlayersByPosition('Flank', 2);
    List<AssessmentModel> kiperPlayers = _getBestPlayersByPosition('Kiper', 1);

    List<AssessmentModel> anchorCadangan =
        _getBestPlayersByPosition('Anchor', 2, 1);
    List<AssessmentModel> pivotCadangan =
        _getBestPlayersByPosition('Pivot', 2, 1);
    List<AssessmentModel> flankCadangan =
        _getBestPlayersByPosition('Flank', 4, 2);
    List<AssessmentModel> kiperCadangan =
        _getBestPlayersByPosition('Kiper', 2, 1);

    players = [
      Player(
        image: 'assets/images/player_jersey.png',
        top: 0.05,
        left: 0.33,
        name: kiperPlayers.isNotEmpty ? kiperPlayers[0].playerName : '',
        posisi: kiperPlayers.isNotEmpty ? kiperPlayers[0].posisi : '',
      ),
      Player(
        image: 'assets/images/kiper_jersey.png',
        top: 0.28,
        left: 0.30,
        name: anchorPlayers.isNotEmpty ? anchorPlayers[0].playerName : '',
        posisi: anchorPlayers.isNotEmpty ? anchorPlayers[0].posisi : '',
      ),
      Player(
        image: 'assets/images/kiper_jersey.png',
        top: 0.45,
        left: 0.6,
        name: flankPlayers.length > 0 ? flankPlayers[0].playerName : '',
        posisi: flankPlayers.length > 0 ? flankPlayers[0].posisi : '',
      ),
      Player(
        image: 'assets/images/kiper_jersey.png',
        top: 0.45,
        left: 0.1,
        name: flankPlayers.length > 1 ? flankPlayers[1].playerName : '',
        posisi: flankPlayers.length > 1 ? flankPlayers[1].posisi : '',
      ),
      Player(
        image: 'assets/images/kiper_jersey.png',
        top: 0.6,
        left: 0.33,
        name: pivotPlayers.isNotEmpty ? pivotPlayers[0].playerName : '',
        posisi: pivotPlayers.isNotEmpty ? pivotPlayers[0].posisi : '',
      ),
    ];

    substitutePlayers = [
      ...kiperCadangan.map((player) => Player(
          image: 'assets/images/player_jersey.png',
          top: 0,
          left: 0,
          name: player.playerName,
          posisi: player.posisi)),
      ...anchorCadangan.map((player) => Player(
          image: 'assets/images/kiper_jersey.png',
          top: 0,
          left: 0,
          name: player.playerName,
          posisi: player.posisi)),
      ...flankCadangan.map((player) => Player(
          image: 'assets/images/kiper_jersey.png',
          top: 0,
          left: 0,
          name: player.playerName,
          posisi: player.posisi)),
      ...pivotCadangan.map((player) => Player(
          image: 'assets/images/kiper_jersey.png',
          top: 0,
          left: 0,
          name: player.playerName,
          posisi: player.posisi)),
    ];
  }

  List<AssessmentModel> _getBestPlayersByPosition(String position, int count,
      [int start = 0]) {
    List<AssessmentModel> filteredPlayers = _assessments
        .where((assessment) => assessment.posisi == position)
        .toList();

    filteredPlayers.sort(
        (a, b) => _calculateTotalScore(b).compareTo(_calculateTotalScore(a)));

    return filteredPlayers.skip(start).take(count).toList();
  }

  double _calculateTotalScore(AssessmentModel player) {
    var criteria = player.aspect.first.criteria;
    var coreFactors = criteria.coreFactor.keys.toList();
    var secondaryFactors = criteria.secondaryFactor.keys.toList();

    double coreScore = 0;
    double secondaryScore = 0;

    for (var factor in coreFactors) {
      double selisih = player.aspect.first.calculateSelisih(factor);
      coreScore += player.aspect.first.getBobotNilai(selisih);
    }
    double ncf = coreScore / coreFactors.length;

    for (var factor in secondaryFactors) {
      double selisih = player.aspect.first.calculateSelisih(factor);
      secondaryScore += player.aspect.first.getBobotNilai(selisih);
    }
    double nsf = secondaryScore / secondaryFactors.length;

    double totalScore = (ncf * 0.6) + (nsf * 0.4);

    return totalScore;
  }

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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  const SizedBox(height: 20),
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
                            child: Column(
                              children: [
                                Image.asset(
                                  player.image,
                                  height: 60,
                                  width: 60,
                                ),
                                Container(
                                  height: 17,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.blueAccent,
                                  ),
                                  child: Center(
                                    child: Text(
                                      player.posisi,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  player.name,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: size.height * 0.05,
                          width: size.width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.tosca,
                          ),
                          child: const Center(
                            child: Text(
                              'Pemain Cadangan',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: substitutePlayers.map((player) {
                            String firstName = player.name.split(' ')[0];

                            return Card(
                              elevation: 4,
                              shadowColor: Colors.black54,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      player.image,
                                      height: 55,
                                      width: 55,
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      height: 17,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.blueAccent,
                                      ),
                                      child: Center(
                                        child: Text(
                                          player.posisi,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ), // Jarak antara gambar dan nama
                                    Text(
                                      firstName,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ));
  }
}

class Player {
  final String image;
  final double top;
  final double left;
  final String name;
  final String posisi;

  Player({
    required this.image,
    required this.top,
    required this.left,
    this.name = '',
    this.posisi = '',
  });
}

class SubPlayer {
  final String image;
  final String name;

  SubPlayer({required this.image, this.name = ''});
}
