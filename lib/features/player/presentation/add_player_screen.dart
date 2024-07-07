import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lineups/service/api_service.dart';
import 'package:lineups/utils/colors.dart';
import 'package:dotted_border/dotted_border.dart';

class AddPlayerScreen extends StatefulWidget {
  const AddPlayerScreen({super.key});

  @override
  State<AddPlayerScreen> createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen> {
  TextEditingController _namePlayerController = TextEditingController();
  TextEditingController _jerseyNumberController = TextEditingController();

  ApiService apiService = ApiService();

  File? _imageFile;
  bool isAspek = false;
  String selectedPosisi = '';

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
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
          'Tambah Pemain',
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
              const SizedBox(height: 30),
              const Text(
                'Foto Pemain',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: _pickImage,
                child: SizedBox(
                  height: size.height * 0.3,
                  width: size.width * 0.4,
                  child: Container(
                    color: Colors.white,
                    child: DottedBorder(
                      padding: const EdgeInsets.all(8),
                      radius: const Radius.circular(8),
                      borderType: BorderType.RRect,
                      strokeWidth: 0.5,
                      color: const Color(0xffC4C4C4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: _imageFile == null
                                  ? Container(
                                      width: size.width * 0.1,
                                      height: size.width * 0.1,
                                      decoration: BoxDecoration(
                                        color: AppColors.greenColor,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.add,
                                          color: AppColors.bgColor,
                                        ),
                                      ),
                                    )
                                  : Image.file(
                                      _imageFile!,
                                      height: size.height * 0.3,
                                      width: size.width * 0.4,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                    controller: _namePlayerController,
                    onChanged: (value) {},
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Masukkan Nama Pemain*",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 12,
                          color: AppColors.greySixColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
                            fontWeight: FontWeight.bold,
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
                'No Punggung',
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
                    controller: _jerseyNumberController,
                    onChanged: (value) {},
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Masukkan No Punggung Pemain*",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 12,
                          color: AppColors.greySixColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
                    onTap: () {
                      _addPlayer();
                    },
                    child: const Center(
                      child: Text(
                        'Tambah Pemain',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: AppColors.whiteTextColor),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _addPlayer() {
    if (_namePlayerController.text.isEmpty ||
        _jerseyNumberController.text.isEmpty ||
        selectedPosisi.isEmpty) {
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
      return;
    }

    apiService
        .addPlayer(
      _namePlayerController.text,
      selectedPosisi,
      int.parse(_jerseyNumberController.text),
    )
        .then((success) {
      if (success) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Berhasil'),
            content: Text('Pemain berhasil ditambahkan.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Gagal Menambahkan Pemain'),
            content: Text('Terjadi kesalahan saat menambahkan pemain.'),
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
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Terjadi kesalahan: $error'),
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
    });
  }

  Future<dynamic> _showModalBottomPosisi(BuildContext context, Size size) {
    List<String> listPosisi = ['Pivot', 'Anchor', 'Flank', 'Kiper'];

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: size.height * 0.6),
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
}
