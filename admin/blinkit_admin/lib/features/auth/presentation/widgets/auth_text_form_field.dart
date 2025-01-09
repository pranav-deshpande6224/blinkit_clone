import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData prefixIcon;
  final IconButton? suffixIcon;
  final bool isObscure;
  final String? Function(String?)? validator;
  const AuthTextFormField({
    required this.controller,
    required this.hintText,
    this.isObscure = false,
    this.suffixIcon,
    required this.validator,
    required this.prefixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      cursorColor: Colors.black,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: suffixIcon,
              )
            : null,
      ),
    );
  }
}
