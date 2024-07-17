import 'package:flutter/material.dart';
import 'package:lineups/config/user_provider.dart';
import 'package:lineups/features/dashboard/presentation/home_tab.dart';
import 'package:lineups/features/kriteria/data/models/kriteria_model.dart';
import 'package:lineups/features/kriteria/presentation/add_kriteria.dart';
import 'package:lineups/features/kriteria/presentation/edit_kriteria.dart';
import 'package:lineups/service/api_service.dart';
import 'package:lineups/utils/colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';

class KriteriaScreen extends StatefulWidget {
  const KriteriaScreen({super.key});

  @override
  State<KriteriaScreen> createState() => _KriteriaScreenState();
}

class _KriteriaScreenState extends State<KriteriaScreen> {
  ApiService apiService = ApiService();
  List<KriteriaModel> criteria = [];
  bool isLoading = true; // State untuk menandai apakah data sedang dimuat

  @override
  void initState() {
    super.initState();
    _fetchCriteria();
  }

  // Fungsi untuk mengambil data kriteria dari API
  void _fetchCriteria() async {
    try {
      List<KriteriaModel> fetchedCriteria = await apiService.getKriteria();
      setState(() {
        criteria = fetchedCriteria;
        isLoading = false; // Set isLoading ke false saat data sudah diambil
      });
    } catch (e) {
      print('Error fetching kriteria: $e');
      setState(() {
        isLoading = false; // Set isLoading ke false meskipun ada error
      });
      // Handle error, show snackbar, etc.
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
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
          'Kriteria Penilaian',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: AppColors.bgColor,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 25, right: 25, bottom: 70),
              child: Column(
                children: [
                  isLoading
                      ? _buildShimmerList(size)
                      : _buildKriteriaList(size, user!.role),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: user!.role != 'Pemain'
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddKriteriaScreen(),
                  ),
                );
              },
              backgroundColor: AppColors.yellow,
              shape: const CircleBorder(),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
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
          const SizedBox(height: 20),
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

  // Fungsi untuk membangun list kriteria
  Widget _buildKriteriaList(Size size, String role) {
    return ListView.separated(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // Disable scrolling in ListView
      itemCount: criteria.length,
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 20), // Jarak antara item
      itemBuilder: (BuildContext context, int index) {
        KriteriaModel kriteria = criteria[index];
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
                  offset: const Offset(0, 2), // changes position of shadow
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            kriteria.criteria,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            kriteria.assessmentAspect,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/icons/player.png',
                        width: 30,
                        height: 30,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: size.width,
                    child: const Divider(thickness: 1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Target',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyColor),
                      ),
                      Text(
                        kriteria.target,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Type',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyColor),
                      ),
                      Text(
                        kriteria.criteriaType,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: size.width,
                    child: const Divider(thickness: 1),
                  ),
                  const SizedBox(height: 5),
                  if (role != 'Pemain')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            _showEditKriteriaScreen(kriteria);
                          },
                          child: Container(
                            height: size.height * 0.04,
                            width: size.height * 0.11,
                            decoration: BoxDecoration(
                                color: AppColors.greenColor,
                                borderRadius: BorderRadius.circular(16)),
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
                                      color: AppColors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _showDeleteConfirmationDialog(criteria[index].id);
                          },
                          child: const Text(
                            'Delete',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.redColorDasboard),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Fungsi untuk menghapus kriteria
  void _deleteAspek(String id) async {
    try {
      bool success = await apiService.deleteKriteria(id);
      if (success) {
        print('Kriteria deleted successfully');
        _fetchCriteria(); // Refresh list after deleting
      } else {
        print('Failed to delete kriteria');
      }
    } catch (e) {
      print('Error: $e');
      // Handle error, show snackbar, etc.
    }
  }

  // Fungsi untuk menampilkan layar edit
  Future<void> _showEditKriteriaScreen(KriteriaModel kriteria) async {
    bool? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditKriteriaScreen(kriteria: kriteria),
      ),
    );

    if (result == true) {
      _fetchCriteria();
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
