import 'package:flutter/material.dart';

class TabletLogin extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const TabletLogin({
    required this.emailController,
    required this.passwordController,
    super.key});

  @override
  State<TabletLogin> createState() => _TabletLoginState();
}

class _TabletLoginState extends State<TabletLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
    );
  }
}