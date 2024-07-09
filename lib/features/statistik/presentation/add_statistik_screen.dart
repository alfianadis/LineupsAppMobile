import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lineups/features/player/data/models/player_model.dart';
import 'package:lineups/features/statistik/presentation/success_screen_stats.dart';
import 'package:lineups/service/api_service.dart';
import 'package:lineups/utils/colors.dart';

class AddStatistikScreen extends StatefulWidget {
  const AddStatistikScreen({super.key});

  @override
  State<AddStatistikScreen> createState() => _AddStatistikScreenState();
}

class _AddStatistikScreenState extends State<AddStatistikScreen> {
  final ApiService _apiService = ApiService();

  String selectedPosisi = '';
  String selectedPemain = '';

  List<PlayerModel> _players = [];

//controller nilai statistik
  TextEditingController _jumlahGolController = TextEditingController();
  TextEditingController _accelerationController = TextEditingController();
  TextEditingController _shootingController = TextEditingController();
  TextEditingController _crossingController = TextEditingController();
  TextEditingController _ballControlController = TextEditingController();
  TextEditingController _bodyBalanceController = TextEditingController();
  TextEditingController _enduranceController = TextEditingController();
  TextEditingController _intersepController = TextEditingController();
  TextEditingController _visionController = TextEditingController();
  TextEditingController _passingController = TextEditingController();
  TextEditingController _throughPassController = TextEditingController();
  TextEditingController _saveController = TextEditingController();
  TextEditingController _refleksController = TextEditingController();
  TextEditingController _jumpController = TextEditingController();
  TextEditingController _throwingController = TextEditingController();

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
          'Tambah Statistik Pemain',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
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
                    if (selectedPosisi.isNotEmpty) {
                      await _fetchPlayersByPosition(selectedPosisi);
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
                        const SizedBox(width: 10),
                        selectedPosisi.isNotEmpty
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedPosisi = '';
                                    _players = [];
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
                        const SizedBox(width: 10),
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
                const SizedBox(height: 15),
                //attack
                Container(
                  height: 20,
                  width: 80,
                  decoration: BoxDecoration(
                    color: AppColors.yellow,
                    borderRadius: BorderRadius.circular(8),
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
                SizedBox(
                  width: size.width,
                  child: const Divider(thickness: 1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Gol',
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
                              controller: _jumlahGolController,
                              onChanged: (value) {},
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
                              keyboardType: TextInputType.number,
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
                          'Shooting',
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
                              controller: _shootingController,
                              onChanged: (value) {},
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
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Acceleration',
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
                              controller: _accelerationController,
                              onChanged: (value) {},
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
                              keyboardType: TextInputType.number,
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
                          'Crossing',
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
                              controller: _crossingController,
                              onChanged: (value) {},
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
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 15),
                //Defence
                Container(
                  height: 20,
                  width: 80,
                  decoration: BoxDecoration(
                    color: AppColors.yellow,
                    borderRadius: BorderRadius.circular(8),
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
                SizedBox(
                  width: size.width,
                  child: const Divider(thickness: 1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ball Control',
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
                              controller: _ballControlController,
                              onChanged: (value) {},
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
                              keyboardType: TextInputType.number,
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
                          'Body Balance',
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
                              controller: _bodyBalanceController,
                              onChanged: (value) {},
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
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Endurance',
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
                              controller: _enduranceController,
                              onChanged: (value) {},
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
                              keyboardType: TextInputType.number,
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
                          'Intersep',
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
                              controller: _intersepController,
                              onChanged: (value) {},
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
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                //Taktikal
                Container(
                  height: 20,
                  width: 80,
                  decoration: BoxDecoration(
                    color: AppColors.yellow,
                    borderRadius: BorderRadius.circular(8),
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
                SizedBox(
                  width: size.width,
                  child: const Divider(thickness: 1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Vision',
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
                              controller: _visionController,
                              onChanged: (value) {},
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
                              keyboardType: TextInputType.number,
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
                          'Passing',
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
                              controller: _passingController,
                              onChanged: (value) {},
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
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Through Pass',
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
                          controller: _throughPassController,
                          onChanged: (value) {},
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
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                //Goal Keeper
                Container(
                  height: 20,
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColors.yellow,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Goal Keeper',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width,
                  child: const Divider(thickness: 1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Save',
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
                              controller: _saveController,
                              onChanged: (value) {},
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
                              keyboardType: TextInputType.number,
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
                          'Refleks',
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
                              controller: _refleksController,
                              onChanged: (value) {},
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
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Jump',
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
                              controller: _jumpController,
                              onChanged: (value) {},
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
                              keyboardType: TextInputType.number,
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
                          'Throwing',
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
                              controller: _throwingController,
                              onChanged: (value) {},
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
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                //button submit
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
                        submitStatistik();
                      },
                      child: const Center(
                        child: Text(
                          'Submit Statistik',
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
            ),
          ),
        ),
      ),
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

  // Add this method to show an alert dialog
  void _showAlertDialog(BuildContext context, String message) {
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

  Future<void> submitStatistik() async {
    // Check if all fields are filled
    if (selectedPosisi.isEmpty ||
        selectedPemain.isEmpty ||
        _jumlahGolController.text.isEmpty ||
        _shootingController.text.isEmpty ||
        _accelerationController.text.isEmpty ||
        _crossingController.text.isEmpty ||
        _ballControlController.text.isEmpty ||
        _bodyBalanceController.text.isEmpty ||
        _enduranceController.text.isEmpty ||
        _intersepController.text.isEmpty ||
        _visionController.text.isEmpty ||
        _passingController.text.isEmpty ||
        _throughPassController.text.isEmpty ||
        _saveController.text.isEmpty ||
        _refleksController.text.isEmpty ||
        _jumpController.text.isEmpty ||
        _throwingController.text.isEmpty) {
      _showAlertDialog(context, "Please fill in all the fields.");
      return;
    }

    final data = {
      "posisi": selectedPosisi,
      "player_name": selectedPemain,
      "attack": {
        "Gol": int.parse(_jumlahGolController.text),
        "Shooting": int.parse(_shootingController.text),
        "Acceleration": int.parse(_accelerationController.text),
        "Crossing": int.parse(_crossingController.text),
      },
      "defence": {
        "Ball_Control": int.parse(_ballControlController.text),
        "Body_Balance": int.parse(_bodyBalanceController.text),
        "Endurance": int.parse(_enduranceController.text),
        "Intersep": int.parse(_intersepController.text),
      },
      "taktikal": {
        "Vision": int.parse(_visionController.text),
        "Passing": int.parse(_passingController.text),
        "Through_Pass": int.parse(_throughPassController.text),
      },
      "keeper": {
        "Save": int.parse(_saveController.text),
        "Refleks": int.parse(_refleksController.text),
        "Jump": int.parse(_jumpController.text),
        "Throwing": int.parse(_throwingController.text),
      }
    };

    try {
      final response = await _apiService.submitStatistik(data);
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
          MaterialPageRoute(builder: (context) => const SuccessScreenStats()),
        );
      } else {
        // Handle error
        print('Failed to submit statistics: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
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
}
