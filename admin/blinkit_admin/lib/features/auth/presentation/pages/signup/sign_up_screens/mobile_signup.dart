import 'package:flutter/material.dart';

class MobileSignup extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;  
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  const MobileSignup({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    super.key});

  @override
  State<MobileSignup> createState() => _MobileSignupState();
}

class _MobileSignupState extends State<MobileSignup> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}