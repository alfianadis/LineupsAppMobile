import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lineups/features/aspek/data/models/aspek_model.dart';
import 'package:lineups/features/kriteria/data/models/kriteria_model.dart';
import 'package:lineups/service/api_service.dart';
import 'package:lineups/utils/colors.dart';

class AddKriteriaScreen extends StatefulWidget {
  const AddKriteriaScreen({super.key});

  @override
  State<AddKriteriaScreen> createState() => _AddKriteriaScreenState();
}

class _AddKriteriaScreenState extends State<AddKriteriaScreen> {
  TextEditingController _nameAspekController = TextEditingController();

  // variabel
  bool isAspek = false;

  String selectedPosisi = '';
  String selectedAspek = '';
  String selectedTarget = '';
  String selectedTipeKriteria = '';

  ApiService _apiService = ApiService();

  void _addKriteria() async {
    // Validasi semua field harus diisi
    if (selectedPosisi.isNotEmpty &&
        selectedAspek.isNotEmpty &&
        _nameAspekController.text.isNotEmpty &&
        selectedTarget.isNotEmpty &&
        selectedTipeKriteria.isNotEmpty) {
      // Membuat objek KriteriaModel dari input yang telah dipilih
      KriteriaModel kriteria = KriteriaModel(
        id: '', // Anda bisa mengisi ID jika ada atau biarkan kosong tergantung dari API
        posisi: selectedPosisi,
        assessmentAspect: selectedAspek,
        criteria: _nameAspekController.text,
        target: selectedTarget,
        criteriaType: selectedTipeKriteria,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        v: 0,
      );

      try {
        // Memanggil metode _apiService.addKriteria untuk mengirim data ke API
        bool result = await _apiService.addKriteria(kriteria);

        if (result) {
          // Jika berhasil, tampilkan pesan sukses dan tutup modal
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Kriteria berhasil ditambahkan!'),
            ),
          );
          Navigator.pop(context);
        } else {
          // Jika gagal, tampilkan pesan gagal
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Gagal menambahkan kriteria!'),
            ),
          );
        }
      } catch (e) {
        // Tangkap error jika terjadi masalah dalam pengiriman data
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Terjadi kesalahan saat menambahkan kriteria!'),
          ),
        );
      }
    } else {
      // Jika ada field yang belum terisi, tampilkan pesan untuk mengisi semua field
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua field harus diisi!'),
        ),
      );
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
          'Tambah Kriteria',
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
              const SizedBox(height: 25),
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
                'Aspek Penilaian',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () async {
                  // Menampilkan modal bottom sheet ketika InkWell diklik
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
                              : 'Masukkan Aspek',
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
                                // Reset nilai aspek yang dipilih
                                setState(() {
                                  selectedAspek = '';
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
                'Kriteria',
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
                  padding: const EdgeInsets.only(left: 20, top: 8),
                  child: TextFormField(
                    controller: _nameAspekController,
                    onChanged: (value) {},
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Masukkan Nama Kriteria",
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
                'Target',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () async {
                  // Menampilkan modal bottom sheet ketika InkWell diklik
                  await _showModalBottomTarget(context, size);
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
                          selectedTarget.isNotEmpty
                              ? selectedTarget
                              : 'Pilih Target',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: selectedTarget.isNotEmpty
                                ? FontWeight.bold
                                : FontWeight.w200,
                            color: selectedTarget.isNotEmpty
                                ? AppColors.neutralColor
                                : AppColors.greySixColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      selectedTarget.isNotEmpty
                          ? InkWell(
                              onTap: () {
                                // Reset nilai aspek yang dipilih
                                setState(() {
                                  selectedTarget = '';
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
                'Tipe Kriteria',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () async {
                  // Menampilkan modal bottom sheet ketika InkWell diklik
                  await _showModalBottomTipeKriteria(context, size);
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
                          selectedTipeKriteria.isNotEmpty
                              ? selectedTipeKriteria
                              : 'Pilih Tipe Kriteria',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: selectedTipeKriteria.isNotEmpty
                                ? FontWeight.bold
                                : FontWeight.w200,
                            color: selectedTipeKriteria.isNotEmpty
                                ? AppColors.neutralColor
                                : AppColors.greySixColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      selectedTipeKriteria.isNotEmpty
                          ? InkWell(
                              onTap: () {
                                // Reset nilai aspek yang dipilih
                                setState(() {
                                  selectedTipeKriteria = '';
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
                    onTap: _addKriteria,
                    child: const Center(
                      child: Text(
                        'Tambah Kriteria',
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

  Future<dynamic> _showModalBottomAspek(BuildContext context, Size size) async {
    ApiService apiService = ApiService();
    List<AspekModel> listAspek = [];

    try {
      listAspek = await apiService.getAspeks();
    } catch (e) {
      // Tampilkan pesan error jika gagal memuat data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load aspects: $e')),
      );
    }

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
                      // ListView.builder untuk membuat daftar aspek
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: listAspek.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              // Memperbarui state dan menutup modal bottom sheet ketika aspek dipilih
                              setState(() {
                                selectedAspek =
                                    listAspek[index].assessmentAspect;
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
                                  listAspek[index].assessmentAspect,
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

  Future<dynamic> _showModalBottomTarget(BuildContext context, Size size) {
    // Contoh sumber data aspek (gantilah dengan sumber data yang sesuai)
    List<String> listTarget = ['1', '2', '3', '4'];

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
                          'Pilih Target',
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
                      // ListView.builder untuk membuat daftar aspek
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: listTarget.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              // Memperbarui state dan menutup modal bottom sheet ketika aspek dipilih
                              setState(() {
                                selectedTarget = listTarget[index];
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
                                  listTarget[index],
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

  Future<dynamic> _showModalBottomTipeKriteria(
      BuildContext context, Size size) {
    // Contoh sumber data aspek (gantilah dengan sumber data yang sesuai)
    List<String> listTipeKriteria = ['Core Factor', 'Secondary Factor'];

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
                        'Pilih Tipe Kriteria',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      // ListView.builder untuk membuat daftar aspek
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: listTipeKriteria.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              // Memperbarui state dan menutup modal bottom sheet ketika aspek dipilih
                              setState(() {
                                selectedTipeKriteria = listTipeKriteria[index];
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
                                  listTipeKriteria[index],
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
