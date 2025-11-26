// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jolly_podcast/Features/podcast/domain/entities/episode_entity.dart';
import 'package:jolly_podcast/core/common/color/app_color.dart';
import 'package:jolly_podcast/core/common/custom_text.dart';
import 'package:sizer/sizer.dart';

class EditorPickCard extends StatelessWidget {
  const EditorPickCard({super.key, required this.editorpick});

  final EpisodeEntity? editorpick;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(right: 2.w, left: 2.w),
          width: 100.w,
          height: 22.h,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(9),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColor.faintGreen, AppColor.lightGreen],
            ),
          ),
          child: Row(
            children: [
              Container(
                height: 20.h,
                width: 46.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0.h),
                  image: DecorationImage(
                    image: NetworkImage(editorpick?.picture_url ?? ''),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsetsGeometry.only(top: 1.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: editorpick?.title ?? '',
                        fontWeight: FontWeight.w800,
                      ),
                      SizedBox(
                        width: 50.w,
                        child: CustomText(
                          text: editorpick?.description ?? '',
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          //rr  overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BoxTiles extends StatefulWidget {
  const BoxTiles({super.key, required this.assetName, required this.title});
  final String assetName;
  final String title;

  @override
  State<BoxTiles> createState() => _BoxTilesState();
}

class _BoxTilesState extends State<BoxTiles> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1.w),
      padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 2.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(widget.assetName),
          SizedBox(width: 0.5.w),
          CustomText(
            text: widget.title,
            fontWeight: FontWeight.w600,
            fontSize: 0.20,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
