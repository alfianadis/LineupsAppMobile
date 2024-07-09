import 'package:flutter/material.dart';
import 'package:lineups/features/aspek/presentation/aspek_screen.dart';
import 'package:lineups/features/dashboard/data/carousel_data.dart';
import 'package:lineups/features/dashboard/model/schedule_model.dart';
import 'package:lineups/features/kriteria/presentation/kriteria_screen.dart';
import 'package:lineups/features/lineup/presentation/lineup_screen.dart';
import 'package:lineups/features/penilaian/presentation/hasil_penilaian_screen.dart';
import 'package:lineups/features/player/presentation/player_screen.dart';
import 'package:lineups/features/statistik/presentation/statistik_screen.dart';
import 'package:lineups/service/api_service.dart';
import 'package:lineups/utils/asset_path.dart';
import 'package:lineups/utils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CarouselController carouselController;
  int innerCurrentPage = 0;

  List<ScheduleModel> schedules = [];
  final ApiService apiService = ApiService();

  @override
  void initState() {
    carouselController = CarouselController();
    super.initState();
    fetchSchedules();
  }

  Future<void> fetchSchedules() async {
    try {
      final fetchedSchedules = await apiService.fetchSchedules();
      setState(() {
        schedules = fetchedSchedules;
      });
    } catch (e) {
      setState(() {});
    }
  }

  String formatDateTime(DateTime dateTime) {
    final DateFormat dayFormat = DateFormat('EEEE, dd MMMM yyyy', 'id_ID');
    final DateFormat timeFormat = DateFormat('HH:mm');
    return '${dayFormat.format(dateTime)}, ${timeFormat.format(dateTime)}';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Hello,',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'Alfian Adi Septianto',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                //iklan slider

                Column(
                  children: [
                    SizedBox(
                      height: size.height * .25,
                      width: size.width,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned.fill(
                            child: CarouselSlider(
                              carouselController: carouselController,
                              options: CarouselOptions(
                                autoPlay: true,
                                aspectRatio: 2.39 / 1,
                                enlargeCenterPage: true,
                                enableInfiniteScroll: true,
                                viewportFraction: 0.8,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    innerCurrentPage = index;
                                  });
                                },
                              ),
                              items: [
                                'assets/images/banner_4.png',
                                'assets/images/banner_2.png',
                                'assets/images/banner_3.png',
                              ].map((item) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      // decoration: BoxDecoration(
                                      //   color: Theme.of(context)
                                      //       .dialogBackgroundColor,
                                      // ),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 1.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(14.0),
                                        child: Image.asset(
                                          item,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          Positioned(
                            bottom: size.height * .04,
                            child: Row(
                              children: List.generate(
                                AppData.innerStyleImages.length,
                                (index) {
                                  bool isSelected = innerCurrentPage == index;
                                  return GestureDetector(
                                    onTap: () {
                                      carouselController.animateToPage(index);
                                    },
                                    child: AnimatedContainer(
                                      width: isSelected ? 30 : 17,
                                      height: 7,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: isSelected ? 6 : 3),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(
                                          18,
                                        ),
                                      ),
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      height: size.height * 0.03,
                      width: 5,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Fitur',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PlayerScreen(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              height: size.height * 0.09,
                              width: size.width * 0.19,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: size.width * 0.3,
                                  height: size.height * 0.06,
                                  child: Image.asset(
                                    AssetPath.playeruniform,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Data Pemain',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AspekScreen(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              height: size.height * 0.09,
                              width: size.width * 0.19,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: size.width * 0.3,
                                  height: size.height * 0.06,
                                  child: Image.asset(
                                    AssetPath.aspek,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Data Aspek',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const KriteriaScreen(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              height: size.height * 0.09,
                              width: size.width * 0.19,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: size.width * 0.3,
                                  height: size.height * 0.06,
                                  child: Image.asset(
                                    AssetPath.kriteria,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Data Kriteria',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ResultSPKScreen(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              height: size.height * 0.09,
                              width: size.width * 0.19,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: size.width * 0.3,
                                  height: size.height * 0.06,
                                  child: Image.asset(
                                    AssetPath.nilai,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Penilaian',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const StatistikScreen(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              height: size.height * 0.09,
                              width: size.width * 0.19,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: size.width * 0.3,
                                  height: size.height * 0.05,
                                  child: Image.asset(
                                    AssetPath.stats,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Statistik',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LineupScreen(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              height: size.height * 0.09,
                              width: size.width * 0.19,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: size.width * 0.3,
                                  height: size.height * 0.06,
                                  child: Image.asset(
                                    AssetPath.lineup2,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Line Up',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      height: size.height * 0.03,
                      width: 5,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Jadwal',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                _buildScheduleList(size),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleList(Size size) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: schedules.length,
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 20),
      itemBuilder: (BuildContext context, int index) {
        return Center(
          child: Container(
            height: size.height * 0.16,
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
                    children: [
                      Image.asset(
                        'assets/icons/player.png',
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${schedules[index].activityName}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: size.width,
                    child: const Divider(thickness: 1),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: AppColors.greyColor,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formatDateTime(schedules[index].activityTime),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.place,
                            color: AppColors.chart01,
                          ),
                          SizedBox(width: 10),
                          Text(
                            '${schedules[index].activityLocation}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
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
}
