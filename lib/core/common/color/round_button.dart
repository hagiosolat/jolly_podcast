import 'package:flutter/material.dart';
import 'package:jolly_podcast/core/common/color/app_color.dart';
import 'package:jolly_podcast/core/common/custom_text.dart';
import 'package:sizer/sizer.dart';

class GenericButton extends StatefulWidget {
  const GenericButton({
    super.key,
    required this.name,
    required this.ontap,
    required this.isLoading,
  });
  final String name;
  final VoidCallback ontap;
  final bool isLoading;

  @override
  State<GenericButton> createState() => _GenericButtonState();
}

class _GenericButtonState extends State<GenericButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
        height: 6.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.w),
          color: AppColor.buttonColor,
        ),
        child: Center(
          child: widget.isLoading
              ? CircularProgressIndicator(
                  backgroundColor: AppColor.backgroundGreen,
                )
              : CustomText(
                  text: widget.name,
                  fontSize: 0.26,
                  fontWeight: FontWeight.w800,
                ),
        ),
      ),
    );
  }
}
