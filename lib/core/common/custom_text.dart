import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.overflow,
    this.maxLines,
  });
  final String text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
        color: textColor ?? Colors.white,
        fontFamily: 'Nunito',
        fontSize: fontSize?.dp ?? 0.2.dp,
        fontWeight: fontWeight ?? FontWeight.normal,
        overflow: overflow,
      ),
    );
  }
}
