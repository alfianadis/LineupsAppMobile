import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lineups/features/dashboard/presentation/home_tab.dart';
import 'package:lineups/features/penilaian/presentation/new_penilaian_screen.dart';
import 'package:lineups/features/statistik/data/statistik_model.dart';
import 'package:lineups/features/statistik/presentation/add_statistik_screen.dart';
import 'package:lineups/service/api_service.dart';
import 'package:lineups/utils/colors.dart';

class StatistikScreen extends StatefulWidget {
  const StatistikScreen({super.key});

  @override
  State<StatistikScreen> createState() => _StatistikScreenState();
}

class _StatistikScreenState extends State<StatistikScreen> {
  String selectedPosisi = '';
  String selectedPemain = '';
  List<StatistikModel> pemainList = [];
  StatistikModel? selectedPemainStatistik;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPemain();
  }

  Future<void> fetchPemain() async {
    try {
      List<StatistikModel> pemain = await ApiService().fetchPemain();
      setState(() {
        pemainList = pemain;
        isLoading = false;
      });
    } catch (e) {
      // Handle error
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  List<StatistikModel> getPemainByPosisi(String posisi) {
    return pemainList.where((pemain) => pemain.posisi == posisi).toList();
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
          'Statistik Pemain',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
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
                          await _showModalBottomPosisi(context, size);
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
                              const SizedBox(width: 10),
                              selectedPosisi.isNotEmpty
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedPosisi = '';
                                          selectedPemain = '';
                                          selectedPemainStatistik = null;
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
                        'Nama Pemain',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: selectedPosisi.isNotEmpty
                            ? () async {
                                await _showModalBottomPlayer(context, size);
                              }
                            : null,
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
                                  selectedPemain.isNotEmpty
                                      ? selectedPemain
                                      : 'Pilih Pemain',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: selectedPemain.isNotEmpty
                                        ? FontWeight.bold
                                        : FontWeight.w200,
                                    color: selectedPemain.isNotEmpty
                                        ? AppColors.neutralColor
                                        : AppColors.greySixColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              selectedPemain.isNotEmpty
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedPemain = '';
                                          selectedPemainStatistik = null;
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
                      const SizedBox(height: 20),
                      if (selectedPemainStatistik != null) ...[
                        Center(
                          child: Container(
                            height: size.height * 0.05,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.greyTreeColor,
                            ),
                            child: const Center(
                              child: Text(
                                'Detail Statistik Pemain',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: size.height * 0.05,
                                width: size.width * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.tosca,
                                ),
                                child: const Center(
                                  child: Text(
                                    'Attack',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Jumlah Gol',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${selectedPemainStatistik?.attack.gol}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(thickness: 0.5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Shooting',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${selectedPemainStatistik?.attack.shooting}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(thickness: 0.5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Acceleration',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${selectedPemainStatistik?.attack.acceleration}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(thickness: 0.5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Crossing',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${selectedPemainStatistik?.attack.crossing}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(thickness: 0.5),
                              //Defence
                              const SizedBox(height: 10),
                              Container(
                                height: size.height * 0.05,
                                width: size.width * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.tosca,
                                ),
                                child: const Center(
                                  child: Text(
                                    'Defence',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Ball Control',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${selectedPemainStatistik?.defence.ballControl}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(thickness: 0.5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Body Balance',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${selectedPemainStatistik?.defence.bodyBalance}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(thickness: 0.5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Endurance',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${selectedPemainStatistik?.defence.endurance}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(thickness: 0.5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Intersep',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${selectedPemainStatistik?.defence.intersep}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(thickness: 0.5),
                              //Taktikal
                              const SizedBox(height: 10),
                              Container(
                                height: size.height * 0.05,
                                width: size.width * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.tosca,
                                ),
                                child: const Center(
                                  child: Text(
                                    'Taktikal',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Vison',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${selectedPemainStatistik?.taktikal.vision}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(thickness: 0.5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Passing',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${selectedPemainStatistik?.taktikal.passing}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(thickness: 0.5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Through Pass',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${selectedPemainStatistik?.taktikal.throughPass}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              //Kiper
                              const Divider(thickness: 0.5),
                              const SizedBox(height: 10),
                              Container(
                                height: size.height * 0.05,
                                width: size.width * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.tosca,
                                ),
                                child: const Center(
                                  child: Text(
                                    'Kiper',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Save',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${selectedPemainStatistik?.keeper.save}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(thickness: 0.5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Refleks',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${selectedPemainStatistik?.keeper.refleks}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(thickness: 0.5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Jump',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${selectedPemainStatistik?.keeper.jump}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(thickness: 0.5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Throwing',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${selectedPemainStatistik?.keeper.throwing}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(thickness: 0.5),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
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
                                    builder: (_) => const AssessmentScreen(),
                                  ),
                                );
                              },
                              child: const Center(
                                child: Text(
                                  'Lanjut Penilaian SPK',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: AppColors.whiteTextColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddStatistikScreen(),
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
                      const SizedBox(height: 20),
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
                                selectedPemain = '';
                                selectedPemainStatistik = null;
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
      setState(() {});
    });
  }

  Future<dynamic> _showModalBottomPlayer(BuildContext context, Size size) {
    List<StatistikModel> listPlayer = getPemainByPosisi(selectedPosisi);

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
                        'Pilih Pemain',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: listPlayer.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedPemain = listPlayer[index].playerName;
                                selectedPemainStatistik = listPlayer[index];
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
                                  listPlayer[index].playerName,
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
