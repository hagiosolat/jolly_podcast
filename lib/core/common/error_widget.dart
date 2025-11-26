import 'package:flutter/material.dart';
import 'package:jolly_podcast/core/common/custom_text.dart';
import 'package:sizer/sizer.dart';

Widget errorWidget(String errorMessage) {
  return SingleChildScrollView(
    physics: NeverScrollableScrollPhysics(),
    child: Container(
      clipBehavior: Clip.hardEdge,
      height: 8.h,
      width: 80.w,
      padding: EdgeInsets.only(left: 1.w),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Row(
        children: [
          Icon(Icons.error, color: Colors.white, size: 7.w),
          SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Oops",
                  fontWeight: FontWeight.w700,
                  fontSize: 0.22,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                CustomText(
                  text: errorMessage,
                  maxLines: 2,
                  fontSize: 0.21,
                  overflow: TextOverflow.ellipsis,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
