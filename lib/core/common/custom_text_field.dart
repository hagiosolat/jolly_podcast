import 'package:flutter/material.dart';
import 'package:jolly_podcast/core/common/color/app_color.dart';
import 'package:jolly_podcast/core/common/custom_text.dart';
import 'package:sizer/sizer.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? initialValue, hintText;
  final Widget? icon;
  final Widget? prefixIcon;
  final Color iconColor;
  final bool? obscureText;
  final int? maxLength;
  final bool enabled, enableBorder;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final void Function(String?)? onSaved, onChanged;
  final String? Function(String?)? validator;
  final VoidCallback? iconPressed;
  final VoidCallback? prefixIconPressed;
  final int? minLines;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextCapitalization? textCapitalization;
  final bool? isError;
  final String? errorText;
  final bool? alwaysAddErrorSpace;

  const CustomTextFormField({
    super.key,
    this.labelText,
    this.icon,
    this.maxLength,
    this.iconColor = Colors.green,
    this.obscureText = false,
    this.prefixIcon,
    this.enableBorder = true,
    this.initialValue,
    this.enabled = true,
    this.prefixIconPressed,
    this.hintText,
    this.iconPressed,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.onSaved,
    this.onChanged,
    this.minLines,
    this.floatingLabelBehavior,
    this.isError,
    this.textCapitalization,
    this.validator,
    this.errorText,
    this.alwaysAddErrorSpace = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 7.h,
              padding: EdgeInsets.symmetric(vertical: 1.0.h),
              decoration: BoxDecoration(
                color: AppColor.darkGrey,
                borderRadius: BorderRadius.circular(8.w),
                border: Border.all(
                  color:
                      (isError == true ||
                          (errorText != null && errorText!.isNotEmpty))
                      ? Color(0xFFFF4E64)
                      : Colors.white,
                  width: 1.5,
                ),
              ),
              child: icon != null
                  ? Center(
                      child: TextFormField(
                        textCapitalization:
                            textCapitalization ?? TextCapitalization.none,
                        controller: controller,
                        onSaved: onSaved,
                        maxLength: maxLength,
                        initialValue: initialValue,
                        validator: validator,
                        enabled: enabled,
                        keyboardType: keyboardType,
                        cursorColor: Colors.white,
                        minLines: minLines,
                        maxLines: 1,
                        obscureText: obscureText!,
                        onChanged: onChanged,
                        style: TextStyle(
                          fontSize: 0.24.dp,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Nunito",
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          floatingLabelBehavior: floatingLabelBehavior,
                          prefixIcon: prefixIcon,
                          suffixIcon: IconButton(
                            icon: icon!,
                            onPressed: iconPressed,
                            color: Colors.white,
                            //context.theme.appColors.textHeaderColor,
                            padding: const EdgeInsets.only(right: 0),
                          ),
                          border: InputBorder.none,
                          hintText: hintText,
                          labelText: labelText,
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Nunito",
                          ),
                          hintStyle: TextStyle(color: Colors.white),
                          errorText: null,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: -0.5,
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: TextFormField(
                        textCapitalization:
                            textCapitalization ?? TextCapitalization.none,
                        controller: controller,
                        onSaved: onSaved,
                        initialValue: initialValue,
                        validator: validator,
                        maxLength: maxLength,
                        enabled: enabled,
                        keyboardType: keyboardType,
                        cursorColor: Colors.white,
                        minLines: minLines,
                        maxLines: 1,
                        obscureText: obscureText!,
                        onChanged: onChanged,
                        style: TextStyle(
                          fontSize: 0.24.dp,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Nunito",
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          floatingLabelBehavior: floatingLabelBehavior,
                          prefixIcon: prefixIcon,
                          border: InputBorder.none,
                          counter: SizedBox(),
                          hintText: hintText,
                          labelText: labelText,
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Nunito",
                          ),
                          hintStyle: const TextStyle(color: Colors.white),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: -5,
                          ),
                          errorText: null,
                        ),
                      ),
                    ),
            ),
            if (alwaysAddErrorSpace == true ||
                (isError == true && errorText != null && errorText!.isNotEmpty))
              const SizedBox(height: 8),
            if (errorText != null && errorText!.isNotEmpty) ...[
              CustomText(
                text: errorText!,
                textColor: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ],
          ],
        ),
      ],
    );
  }
}
