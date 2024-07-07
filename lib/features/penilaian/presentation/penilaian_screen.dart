import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lineups/utils/colors.dart';

class PenilaianScreen extends StatefulWidget {
  const PenilaianScreen({super.key});

  @override
  State<PenilaianScreen> createState() => _PenilaianScreenState();
}

class _PenilaianScreenState extends State<PenilaianScreen> {
  TextEditingController _namePlayerController = TextEditingController();

  //variabel
  bool isAspek = false;

  String selectedPosisi = '';
  String selectedPemain = '';

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
                      // Menampilkan modal bottom sheet ketika InkWell diklik
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
                                fontWeight: FontWeight.w200,
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
                      // Menampilkan modal bottom sheet ketika InkWell diklik
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
                                fontWeight: FontWeight.w200,
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
                                    // Reset nilai aspek yang dipilih
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
                  const Text(
                    'Aspek Attack',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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
                            'Poacher',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 80,
                            decoration: BoxDecoration(
                              color: AppColors.yellow,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'Core Factor',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
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
                                controller: _namePlayerController,
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
                            'Finishing',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 80,
                            decoration: BoxDecoration(
                              color: AppColors.yellow,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'Core Factor',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
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
                                controller: _namePlayerController,
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
                            'Shooting',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 115,
                            decoration: BoxDecoration(
                              color: AppColors.chart02,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'Secondary Factor',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
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
                                controller: _namePlayerController,
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
                            'Positioning',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 115,
                            decoration: BoxDecoration(
                              color: AppColors.chart02,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'Secondary Factor',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
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
                                controller: _namePlayerController,
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
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Aspek Strenght',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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
                            'Poacher',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 80,
                            decoration: BoxDecoration(
                              color: AppColors.yellow,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'Core Factor',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
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
                                controller: _namePlayerController,
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
                            'Finishing',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 80,
                            decoration: BoxDecoration(
                              color: AppColors.yellow,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'Core Factor',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
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
                                controller: _namePlayerController,
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
                            'Shooting',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 115,
                            decoration: BoxDecoration(
                              color: AppColors.chart02,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'Secondary Factor',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
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
                                controller: _namePlayerController,
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
                            'Positioning',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 115,
                            decoration: BoxDecoration(
                              color: AppColors.chart02,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'Secondary Factor',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
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
                                controller: _namePlayerController,
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
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Aspek Skills',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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
                            'Movement',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 80,
                            decoration: BoxDecoration(
                              color: AppColors.yellow,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'Core Factor',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
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
                                controller: _namePlayerController,
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
                            'Footwork',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 80,
                            decoration: BoxDecoration(
                              color: AppColors.yellow,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'Core Factor',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
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
                                controller: _namePlayerController,
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
                            'Passing',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 115,
                            decoration: BoxDecoration(
                              color: AppColors.chart02,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'Secondary Factor',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
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
                                controller: _namePlayerController,
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
                            'Dribbling',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 115,
                            decoration: BoxDecoration(
                              color: AppColors.chart02,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'Secondary Factor',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
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
                                controller: _namePlayerController,
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
                        onTap: () {},
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
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showModalBottomPosisi(BuildContext context, Size size) {
    // Contoh sumber data aspek (gantilah dengan sumber data yang sesuai)
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
                      // ListView.builder untuk membuat daftar aspek
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: listPosisi.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              // Memperbarui state dan menutup modal bottom sheet ketika aspek dipilih
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
      // Memperbarui tampilan InkWell setelah modal bottom sheet tertutup
      setState(() {});
    });
  }

  Future<dynamic> _showModalBottomPlayer(BuildContext context, Size size) {
    // Contoh sumber data aspek (gantilah dengan sumber data yang sesuai)
    List<String> listPlayer = [
      'Ardiansyah Runtuboy',
      'Evan Soumilena',
      'Al Bagir',
      'Rizki Xavier',
      'Achmad Habibie',
      'Syauqi Saud',
      'Andri Kustiawan',
      'Mochammad Iqbal Iskandar',
      'Subhan Faidasa',
      'Rio Pangestu',
      'Firman Adriansyah',
      'Fajar Ramadhan',
      'Muhammad Sanjaya',
      'Anzar',
      'Samuel Eko Putra'
    ];
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
                      // ListView.builder untuk membuat daftar aspek
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: listPlayer.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              // Memperbarui state dan menutup modal bottom sheet ketika aspek dipilih
                              setState(() {
                                selectedPemain = listPlayer[index];
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
                                  listPlayer[index],
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
