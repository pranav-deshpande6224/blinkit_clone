import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData prefixIcon;
  final IconButton? suffixIcon;
  final bool isObscure;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  const AuthTextFormField({
    required this.controller,
    required this.hintText,
    this.isObscure = false,
    this.suffixIcon,
    required this.validator,
    required this.prefixIcon,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 400
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,
        onChanged: onChanged,
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
      ),
    );
  }
}
