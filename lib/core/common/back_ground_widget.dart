import 'package:flutter/material.dart';
import 'package:jolly_podcast/core/common/assetsnames/assetname.dart';
import 'package:jolly_podcast/core/common/color/app_color.dart';
import 'package:sizer/sizer.dart';

class AppBaseView extends StatelessWidget {
  const AppBaseView({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: Container(
        margin: EdgeInsets.only(top: 5.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //JOLLY LOGO
                  Image.asset(Appasset.jollyLogo),
                  //THREE BUTTONS AT THE TOP OF THE SCREENS
                  Container(
                    height: 6.5.h,
                    width: 30.1.w,
                    decoration: BoxDecoration(
                      color: AppColor.greyColor,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.notifications, size: 30),
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.search, size: 30),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
