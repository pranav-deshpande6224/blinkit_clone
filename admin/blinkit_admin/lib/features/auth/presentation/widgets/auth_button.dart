import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final Widget widget;
  final void Function() onPressed;
  final Color? color;
  const AuthButton(
      {required this.widget, required this.onPressed, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      child: widget,
    );
  }
}
