import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolly_podcast/Features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:jolly_podcast/core/common/assetsnames/assetname.dart';
import 'package:jolly_podcast/core/common/color/app_color.dart';
import 'package:jolly_podcast/core/common/color/round_button.dart';
import 'package:jolly_podcast/core/common/custom_text.dart';
import 'package:jolly_podcast/core/common/custom_text_field.dart';
import 'package:jolly_podcast/core/common/error_widget.dart';
import 'package:jolly_podcast/core/enum/global_enum.dart';
import 'package:jolly_podcast/core/services/routes.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool showPassword = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthStates>(
      listener: (context, state) {
        if (state.status == LoginStatus.loading) {
          isLoading = true;
        }
        if (state.status == LoginStatus.success) {
          isLoading = false;
          Navigator.pushReplacementNamed(context, AppRoutes.DASHBOARD);
        }
        if (state.status == LoginStatus.failure) {
          isLoading = false;
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                elevation: 0,
                content: errorWidget(state.errorMessage),
              ),
            );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              height: 100.h,
              width: 100.w,
              padding: EdgeInsets.only(left: 3.w, top: 10.h, right: 3.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentGeometry.centerRight,
                  end: AlignmentGeometry.centerLeft,
                  colors: [AppColor.lemonGreen, Color(0xFF89F89C)],
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(Appasset.loginLogo, height: 10.h, width: 35.w),
                  CustomText(
                    text: "Login",
                    fontSize: 0.31,
                    fontWeight: FontWeight.w800,
                  ),
                  SizedBox(height: 1.h),
                  CustomText(
                    text: "Enter Phone Number",
                    fontSize: 0.24,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomTextFormField(
                    controller: phoneNumberController,
                    hintText: "Enter phone number",
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 1.h),
                  CustomText(
                    text: "Enter Password",
                    fontSize: 0.24,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: !showPassword,
                    icon: showPassword
                        ? Icon(Icons.visibility_off_outlined)
                        : Icon(Icons.visibility_outlined),
                    iconPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                  Expanded(child: SizedBox()),
                  GenericButton(
                    name: "Login",
                    isLoading: isLoading,
                    ontap: () {
                      context.read<AuthBloc>().add(
                        LoginEvent(
                          phoneNumber: phoneNumberController.text,
                          passWord: passwordController.text,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
