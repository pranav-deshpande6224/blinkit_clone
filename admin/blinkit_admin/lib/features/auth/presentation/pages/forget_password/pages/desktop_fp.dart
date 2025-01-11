import 'package:blinkit_admin/core/constants/constant_strings.dart';
import 'package:blinkit_admin/features/auth/presentation/widgets/auth_button.dart';
import 'package:blinkit_admin/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:blinkit_admin/features/auth/presentation/widgets/gradient_container.dart';
import 'package:flutter/material.dart';

class DesktopFp extends StatefulWidget {
  final TextEditingController emailController;
  const DesktopFp({required this.emailController, super.key});

  @override
  State<DesktopFp> createState() => _DesktopFpState();
}

class _DesktopFpState extends State<DesktopFp> {
  final _fpKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode();
  final String emailRegExp = Constantstrings.emailRegEx;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        child: Center(
          child: SizedBox(
            width: 400,
            child: Card(
              color: Colors.grey[180],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _fpKey,
                  child: Column(
                    spacing: 20,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Forget Password',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      AuthTextFormField(
                        controller: widget.emailController,
                        hintText: 'Email',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Email is required";
                          }
                          if (!RegExp(emailRegExp).hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                        prefixIcon: Icons.email,
                        focusNode: _emailFocusNode,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: AuthButton(
                          widget: Text('Submit'),
                          onPressed: () {
                            if (!_fpKey.currentState!.validate()) {
                              return;
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
