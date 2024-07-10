import 'package:flutter/material.dart';
import 'package:lineups/features/aspek/data/models/aspek_model.dart';
import 'package:lineups/features/aspek/presentation/add_aspek_screen.dart';
import 'package:lineups/features/aspek/presentation/edit_aspek_screen.dart';
import 'package:lineups/features/dashboard/presentation/home_tab.dart';
import 'package:lineups/service/api_service.dart';
import 'package:lineups/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class AspekScreen extends StatefulWidget {
  const AspekScreen({super.key});

  @override
  State<AspekScreen> createState() => _AspekScreenState();
}

class _AspekScreenState extends State<AspekScreen> {
  ApiService apiService = ApiService();
  List<AspekModel> aspeks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAspeks();
  }

  // Fungsi untuk mengambil data aspeks dari API
  void _fetchAspeks() async {
    try {
      List<AspekModel> fetchedAspeks = await apiService.getAspeks();
      setState(() {
        aspeks = fetchedAspeks;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching aspeks: $e');
      setState(() {
        isLoading = false;
      });
      // Handle error, show snackbar, etc.
    }
  }

  void _editAspek(AspekModel aspek) async {
    bool? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditAspekScreen(aspek: aspek);
      },
    );

    if (result == true) {
      _fetchAspeks(); // Refresh list after editing
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
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
          'Aspek Penilaian',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: AppColors.bgColor,
            padding:
                const EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 30),
            child: Column(
              children: [
                isLoading ? _buildShimmerList(size) : _buildAspekList(size),
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
              builder: (_) => const AddAspekkScreen(),
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

  // Fungsi untuk membangun shimmer list
  Widget _buildShimmerList(Size size) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5, // You can adjust the item count for shimmer effect
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 20),
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: size.height * 0.25,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }

  // Fungsi untuk membangun list aspek
  Widget _buildAspekList(Size size) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: aspeks.length,
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 20),
      itemBuilder: (BuildContext context, int index) {
        return Center(
          child: Container(
            height: size.height * 0.25,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        aspeks[index].assessmentAspect,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Image.asset(
                        'assets/icons/player.png',
                        width: 30,
                        height: 30,
                      ),
                    ],
                  ),
                  const Divider(thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Core Factor',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyColor,
                        ),
                      ),
                      Text(
                        '${aspeks[index].coreFactor}%',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Secondary Factor',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyColor,
                        ),
                      ),
                      Text(
                        '${aspeks[index].secondaryFactor}%',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Divider(thickness: 1),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          _editAspek(aspeks[index]);
                        },
                        child: Container(
                          height: size.height * 0.04,
                          width: size.height * 0.11,
                          decoration: BoxDecoration(
                            color: AppColors.greenColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit_square,
                                color: AppColors.white,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Edit',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _showDeleteConfirmationDialog(aspeks[index].id);
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.redColorDasboard,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Fungsi untuk menghapus aspek
  void _deleteAspek(String id) async {
    try {
      bool success = await apiService.deleteAspek(id);
      if (success) {
        print('Aspek deleted successfully');
        _fetchAspeks(); // Refresh list after deleting
      } else {
        print('Failed to delete aspek');
      }
    } catch (e) {
      print('Error: $e');
      // Handle error, show snackbar, etc.
    }
  }

  Future<void> _showDeleteConfirmationDialog(String id) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          title: const Text(
            'Apakah Anda Yakin Untuk Menghapus Kriteria Ini ?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: 56,
                  decoration: BoxDecoration(
                      color: AppColors.greyTreeColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Text(
                      'Batal',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.of(context).pop();
                  _deleteAspek(id);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: 56,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Text(
                      'Hapus',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
