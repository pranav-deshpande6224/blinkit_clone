import 'package:flutter/material.dart';

class MobileLogin extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const MobileLogin({
    required this.emailController,
    required this.passwordController,
    super.key});

  @override
  State<MobileLogin> createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
    );
  }
}