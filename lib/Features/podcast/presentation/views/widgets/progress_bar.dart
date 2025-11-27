import 'package:flutter/material.dart';
import 'package:jolly_podcast/core/common/color/app_color.dart';
import 'package:sizer/sizer.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    super.key,
    required this.bufferProgress,
    required this.audioProgress,
  });
  final double bufferProgress;
  final double audioProgress;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //THE EMPTY OR START STATE OF THE PROGRESS
        Container(
          width: 90.w,
          height: 1.h,
          decoration: BoxDecoration(
            color: AppColor.faintGreen,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        //Buffer indicator
        Container(
          height: 1.h,
          width: widget.bufferProgress.isNegative
              ? 0.0
              : !widget.bufferProgress.isNaN
              ? (widget.bufferProgress * 90.w)
              : 0.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [AppColor.lightGreen, Colors.white],
            ),
          ),
        ),
        //AUDIO PROGRESS INDICATOR
        Container(
          height: 1.h,
          width: widget.audioProgress.isNegative
              ? 0.0
              : !widget.audioProgress.isNaN
              ? (widget.audioProgress * 90.w)
              : 0.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColor.backgroundGreen,
          ),
        ),
      ],
    );
  }
}
