import 'package:blinkit_admin/core/responsive/responsive_widget.dart';
import 'package:blinkit_admin/features/auth/presentation/pages/login/login_screens/desktop_login.dart';
import 'package:blinkit_admin/features/auth/presentation/pages/login/login_screens/mobile_login.dart';
import 'package:blinkit_admin/features/auth/presentation/pages/login/login_screens/tablet_login.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: MobileLogin(),
      tablet: TabletLogin(),
      desktop: DesktopLogin(),
    );
  }
}
