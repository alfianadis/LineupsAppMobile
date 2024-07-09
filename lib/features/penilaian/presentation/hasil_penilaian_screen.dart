import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lineups/features/dashboard/presentation/home_tab.dart';
import 'package:lineups/features/penilaian/data/models/assesment_model.dart';
import 'package:lineups/features/penilaian/presentation/new_penilaian_screen.dart';
import 'package:lineups/service/api_service.dart';
import 'package:lineups/utils/colors.dart';

class ResultSPKScreen extends StatefulWidget {
  const ResultSPKScreen({super.key});

  @override
  State<ResultSPKScreen> createState() => _ResultSPKScreenState();
}

class _ResultSPKScreenState extends State<ResultSPKScreen> {
  String selectedPosisi = '';
  List<AssessmentModel> players = [];
  List<AssessmentModel> filteredPlayers = [];
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchPlayerData();
  }

  Future<void> fetchPlayerData() async {
    try {
      List<AssessmentModel> data = await apiService.fetchPlayerData();
      setState(() {
        players = data;
        filterPlayersByPosisi();
      });
    } catch (e) {
      // Tangani kesalahan
      print(e);
    }
  }

  void filterPlayersByPosisi() {
    setState(() {
      filteredPlayers =
          players.where((player) => player.posisi == selectedPosisi).toList();
    });
  }

  double calculateScore(AssessmentModel player) {
    var aspect = player.aspect[0];
    List<String> coreFactors = aspect.criteria.coreFactor.keys.toList();
    List<String> secondaryFactors =
        aspect.criteria.secondaryFactor.keys.toList();
    return aspect.calculateScore(coreFactors, secondaryFactors);
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
          'Hasil Penilaian Pemain',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Posisi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () async {
                      // Menampilkan modal bottom sheet ketika InkWell diklik
                      await _showModalBottomPosisi(context, size);
                      filterPlayersByPosisi();
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
                              selectedPosisi.isNotEmpty
                                  ? selectedPosisi
                                  : 'Pilih Posisi',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: selectedPosisi.isNotEmpty
                                    ? FontWeight.bold
                                    : FontWeight.w200,
                                color: selectedPosisi.isNotEmpty
                                    ? AppColors.neutralColor
                                    : AppColors.greySixColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          selectedPosisi.isNotEmpty
                              ? InkWell(
                                  onTap: () {
                                    // Reset nilai aspek yang dipilih
                                    setState(() {
                                      selectedPosisi = '';
                                      filterPlayersByPosisi();
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nama Pemain',
                        style: TextStyle(
                          color: AppColors.greytextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Total Nilai',
                            style: TextStyle(
                              color: AppColors.greytextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: 15),
                          Text(
                            'Rank',
                            style: TextStyle(
                              color: AppColors.greytextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  ...filteredPlayers.asMap().entries.map((entry) {
                    int index = entry.key;
                    AssessmentModel player = entry.value;
                    double finalScore = calculateScore(player);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            width: 5,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: size.width * 0.72,
                            decoration: BoxDecoration(
                              color: AppColors.greyTreeColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    player.playerName,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    finalScore.toStringAsFixed(1),
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: AppColors.greyTreeColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                (index + 1).toString(),
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    );
                  }).toList()
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AssessmentScreen(),
            ),
          );
        },
        backgroundColor: AppColors.yellow,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<dynamic> _showModalBottomPosisi(BuildContext context, Size size) {
    List<String> listPosisi = ['Pivot', 'Anchor', 'Flank', 'Kiper'];

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
                        'Pilih Posisi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: listPosisi.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedPosisi = listPosisi[index];
                              });
                              Navigator.pop(context);
                              filterPlayersByPosisi();
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
      setState(() {});
    });
  }
}
