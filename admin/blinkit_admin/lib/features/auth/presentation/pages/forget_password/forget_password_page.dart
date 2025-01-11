import 'package:blinkit_admin/core/responsive/responsive_widget.dart';
import 'package:blinkit_admin/features/auth/presentation/pages/forget_password/pages/desktop_fp.dart';
import 'package:blinkit_admin/features/auth/presentation/pages/forget_password/pages/mobile_fp.dart';
import 'package:blinkit_admin/features/auth/presentation/pages/forget_password/pages/tablet_fp.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: MobileFp(
        emailController: emailController,
      ),
      tablet: TabletFp(emailController: emailController),
      desktop: DesktopFp(emailController: emailController),
    );
  }
}
