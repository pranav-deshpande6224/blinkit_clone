import 'package:blinkit_admin/core/responsive/responsive_widget.dart';
import 'package:blinkit_admin/features/auth/presentation/pages/signup/sign_up_screens/desktop_signup.dart';
import 'package:blinkit_admin/features/auth/presentation/pages/signup/sign_up_screens/mobile_signup.dart';
import 'package:blinkit_admin/features/auth/presentation/pages/signup/sign_up_screens/tablet_signup.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: MobileSignup(
        nameController: _nameController,
        emailController: _emailController,
        passwordController: _passwordController,
        confirmPasswordController: _confirmPasswordController,
      ),
      tablet: TabletSignup(
        nameController: _nameController,
        emailController: _emailController,
        passwordController: _passwordController,
        confirmPasswordController: _confirmPasswordController,
      ),
      desktop: DesktopSignup(
        nameController: _nameController,
        emailController: _emailController,
        passwordController: _passwordController,
        confirmPasswordController: _confirmPasswordController,
      ),
    );
  }
}
