import 'package:flutter/material.dart';

class TabletSignup extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const TabletSignup({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    super.key});

  @override
  State<TabletSignup> createState() => _TabletSignupState();
}

class _TabletSignupState extends State<TabletSignup> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}