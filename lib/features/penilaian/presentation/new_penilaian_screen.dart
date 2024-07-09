import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lineups/features/kriteria/data/models/kriteria_model.dart';
import 'package:lineups/features/penilaian/presentation/splash_success_spk.dart';
import 'package:lineups/features/player/data/models/player_model.dart';
import 'package:lineups/service/api_service.dart';
import 'package:lineups/utils/colors.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  final ApiService _apiService = ApiService();

  bool isAspek = false;

  String selectedPosisi = '';
  String selectedPemain = '';
  String selectedAspek = '';
  String selectedNilaiCF1 = '';
  String selectedNilaiCF2 = '';
  String selectedNilaiSF1 = '';
  String selectedNilaiSF2 = '';

  List<PlayerModel> _players = [];
  List<KriteriaModel> _criteria = [];
  List<KriteriaModel> _filteredCriteria = [];
  List<String> _filteredAspects = [];
  Map<String, Map<String, String>> criteriaValues = {};

  Map<String, String> coreFactorValues = {};
  Map<String, String> secondaryFactorValues = {};

  @override
  void initState() {
    super.initState();
    _fetchCriteria();
  }

  Future<void> _fetchCriteria() async {
    try {
      final criteria = await _apiService.fetchCriteria();
      setState(() {
        _criteria = criteria;
      });
    } catch (e) {
      print('Error fetching criteria: $e');
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
          'Penilaian Pemain',
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
                      await _showModalBottomPosisi(context, size);
                      if (selectedPosisi.isNotEmpty) {
                        await _fetchPlayersByPosition(selectedPosisi);
                        setState(() {
                          _filteredAspects =
                              _apiService.getAssessmentAspectsByPosition(
                                  _criteria, selectedPosisi);
                        });
                      }
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
                                    setState(() {
                                      selectedPosisi = '';
                                      _players = [];
                                      _filteredAspects = [];
                                      selectedAspek = '';
                                      _filteredCriteria = [];
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
                    onTap: () async {
                      await _showModalBottomPlayer(context, size);
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
                          const SizedBox(
                            width: 10,
                          ),
                          selectedPemain.isNotEmpty
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedPemain = '';
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
                    'Nama Aspek',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () async {
                      await _showModalBottomAspek(context, size);
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
                              selectedAspek.isNotEmpty
                                  ? selectedAspek
                                  : 'Pilih Aspek',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: selectedAspek.isNotEmpty
                                    ? FontWeight.bold
                                    : FontWeight.w200,
                                color: selectedAspek.isNotEmpty
                                    ? AppColors.neutralColor
                                    : AppColors.greySixColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          selectedAspek.isNotEmpty
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedAspek = '';
                                      _filteredCriteria = [];
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
                  if (_filteredCriteria.isNotEmpty) ...[
                    const Text(
                      'Core Factors:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    _buildCriteriaRows(size, 'Core Factor'),
                    const SizedBox(height: 10),
                    const Text(
                      'Secondary Factors:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    _buildCriteriaRows(size, 'Secondary Factor'),
                  ],
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
                        onTap: submitAssessment,
                        child: const Center(
                          child: Text(
                            'Submit Penilaian',
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
        ),
      ),
    );
  }

  Widget _buildCriteriaRows(Size size, String criteriaType) {
    final criteriaList = _filteredCriteria
        .where((item) => item.criteriaType == criteriaType)
        .toList();
    return Column(
      children: List.generate((criteriaList.length / 2).ceil(), (index) {
        int firstIndex = index * 2;
        int secondIndex = firstIndex + 1;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCriteriaItem(size, criteriaList[firstIndex], criteriaType),
            if (secondIndex < criteriaList.length)
              _buildCriteriaItem(size, criteriaList[secondIndex], criteriaType),
          ],
        );
      }),
    );
  }

  Widget _buildCriteriaItem(
      Size size, KriteriaModel criteria, String criteriaType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text(
          criteria.criteria,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          height: 20,
          width: 115,
          decoration: BoxDecoration(
            color: criteriaType == 'Core Factor'
                ? AppColors.yellow
                : AppColors.chart02,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              criteriaType,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "Target Nilai Kriteria ini: ${criteria.target}",
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () async {
            await _showModalBottomNilai(context, size, criteria.criteria);
          },
          child: Container(
            height: size.height * 0.09,
            width: size.width * 0.4,
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: AppColors.greenSecobdColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  criteriaValues.containsKey(criteria.criteria)
                      ? criteriaValues[criteria.criteria]!['value'] ??
                          'Masukkan Nilai'
                      : 'Masukkan Nilai',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w200,
                    color: criteriaValues.containsKey(criteria.criteria)
                        ? AppColors.neutralColor
                        : AppColors.greySixColor,
                  ),
                ),
                SvgPicture.asset(
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
      ],
    );
  }

  Future<void> _fetchPlayersByPosition(String position) async {
    try {
      final players = await _apiService.fetchPlayersByPosition(position);
      setState(() {
        _players = players;
      });
    } catch (e) {
      print('Error fetching players: $e');
    }
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
                        itemCount: _players.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedPemain = _players[index].name;
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
                                  _players[index].name,
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

  Future<dynamic> _showModalBottomAspek(BuildContext context, Size size) {
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
                        'Pilih Aspek',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _filteredAspects.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedAspek = _filteredAspects[index];
                                _filteredCriteria =
                                    _apiService.getCriteriaByAssessmentAspect(
                                        _criteria, selectedAspek);
                                coreFactorValues.clear();
                                secondaryFactorValues.clear();
                                for (var criteria in _filteredCriteria) {
                                  if (criteria.criteriaType == 'Core Factor') {
                                    coreFactorValues[criteria.criteria] =
                                        criteria.target;
                                  } else {
                                    secondaryFactorValues[criteria.criteria] =
                                        criteria.target;
                                  }
                                }
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
                                  _filteredAspects[index],
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

  Future<void> _showModalBottomNilai(
      BuildContext context, Size size, String criteria) async {
    List<String> listNilai = ['1', '2', '3', '4'];

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          'assets/icons/shape.svg',
                          width: 10,
                          height: 5,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: Text(
                          'Masukkan Nilai',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '*Notes Nilai',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '1 - Kurang, 2 - Cukup, 3 - Baik, 4 - Sangat Baik',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: listNilai.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                criteriaValues[criteria] = {
                                  'value': listNilai[index],
                                };
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
                                  listNilai[index],
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

  Future<void> submitAssessment() async {
    if (selectedPosisi.isEmpty) {
      _showAlertDialog("Posisi harus dipilih.");
      return;
    }
    if (selectedPemain.isEmpty) {
      _showAlertDialog("Nama pemain harus dipilih.");
      return;
    }
    if (selectedAspek.isEmpty) {
      _showAlertDialog("Aspek harus dipilih.");
      return;
    }
    for (var criteria in _filteredCriteria) {
      if (!criteriaValues.containsKey(criteria.criteria) ||
          criteriaValues[criteria.criteria]!['value']!.isEmpty) {
        _showAlertDialog("Semua nilai kriteria harus diisi.");
        return;
      }
    }

    List<Map<String, dynamic>> aspectList = [
      {
        "target": {
          for (var criteria in _filteredCriteria)
            criteria.criteria: criteria.target
        },
        "criteria": {
          "core_factor": {
            for (var criteria in _filteredCriteria
                .where((c) => c.criteriaType == 'Core Factor'))
              criteria.criteria: criteriaValues[criteria.criteria]?['value']
          },
          "secondary_factor": {
            for (var criteria in _filteredCriteria
                .where((c) => c.criteriaType == 'Secondary Factor'))
              criteria.criteria: criteriaValues[criteria.criteria]?['value']
          }
        }
      }
    ];

    final assessmentData = {
      "posisi": selectedPosisi,
      "player_name": selectedPemain,
      "aspect_name": selectedAspek,
      "aspect": aspectList,
    };

    print('Data to be sent: ${jsonEncode(assessmentData)}');

    try {
      final response = await _apiService.submitAssessment(assessmentData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Handle success
        print('Assessment submitted successfully');
        // Process the response if needed
        final responseData = jsonDecode(response.body);
        print('Response Data: $responseData');
        // Show success message or navigate to another screen
        // Navigate to SplashSuccessScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SplashSuccessSpk()),
        );
      } else {
        // Handle error
        print(
            'Error submitting assessment: ${response.statusCode} ${response.body}');
        // Show error message
      }
    } catch (e) {
      print('Error: $e');
      // Show error message
    }
  }

  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Peringatan"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
