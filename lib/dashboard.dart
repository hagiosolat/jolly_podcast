// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:jolly_podcast/Features/podcast/presentation/views/podcast_screen.dart';
import 'package:jolly_podcast/core/common/assetsnames/assetname.dart';
import 'package:jolly_podcast/core/common/color/app_color.dart';
import 'package:sizer/sizer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool fromLogin = false;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
    );
    return Scaffold(
      body: IndexedStack(index: 0, children: [PodcastScreen()]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: Color(0xFF1D1D1B),
        elevation: 8,
        selectedLabelStyle: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 0.2.dp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 0.2.dp,
          fontWeight: FontWeight.w700,
          color: AppColor.navbarUnselectedColor,
        ),
        selectedItemColor: Colors.white,
        unselectedItemColor: AppColor.navbarUnselectedColor,
        onTap: (value) {},
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Appasset.discover,
              color: AppColor.navbarUnselectedColor,
            ),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Appasset.categories,
              color: AppColor.navbarUnselectedColor,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Appasset.libraryIcon,
              color: AppColor.navbarUnselectedColor,
            ),
            label: 'Your Library',
          ),
        ],
      ),
    );
  }
}
