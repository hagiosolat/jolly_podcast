import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jolly_podcast/Features/podcast/domain/entities/episode_entity.dart';
import 'package:jolly_podcast/core/common/assetsnames/assetname.dart';
import 'package:jolly_podcast/core/common/color/app_color.dart';
import 'package:jolly_podcast/core/common/custom_text.dart';
import 'package:sizer/sizer.dart';

class EpisodeCard extends StatefulWidget {
  const EpisodeCard({super.key, required this.episode});
  final EpisodeEntity episode;

  @override
  State<EpisodeCard> createState() => _EpisodeCardState();
}

class _EpisodeCardState extends State<EpisodeCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(right: 2.w, left: 2.w),
          width: 75.w,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(9),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(widget.episode.picture_url ?? ''),
            ),
          ),
        ),
        Positioned(
          left: 2.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 0.7.w, vertical: 0.5.h),
            height: 41.h,
            width: 75.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [AppColor.faintGreen, Colors.transparent],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomText(
                  text: widget.episode.title ?? '',
                  fontSize: 0.24,
                  fontWeight: FontWeight.w800,
                  overflow: TextOverflow.ellipsis,
                ),
                CustomText(
                  text: widget.episode.description ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  width: 60.w,
                  margin: EdgeInsets.only(top: 1.h, bottom: 1.h),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.,
                    children: [
                      interactionButton(Appasset.favouriteIcon),
                      interactionButton(Appasset.queueIcon),
                      interactionButton(Appasset.shareIcon),
                      interactionButton(Appasset.addIcon),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget interactionButton(String assetName, [double? borderWidth]) {
  return Container(
    height: 11.w,
    width: 11.w,
    margin: EdgeInsets.only(right: 1.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(7.w),

      border: Border.all(color: Colors.white, width: borderWidth ?? 1.0),
      color: Colors.transparent,
    ),
    child: SvgPicture.asset(assetName, fit: BoxFit.scaleDown),
  );
}
