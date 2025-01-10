import 'package:blinkit_admin/core/constants/constant_strings.dart';
import 'package:blinkit_admin/features/auth/presentation/widgets/auth_button.dart';
import 'package:blinkit_admin/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:flutter/material.dart';

class DesktopSignup extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController nameController;
  const DesktopSignup(
      {required this.emailController,
      required this.passwordController,
      required this.confirmPasswordController,
      required this.nameController,
      super.key});

  @override
  State<DesktopSignup> createState() => _DesktopSignupState();
}

class _DesktopSignupState extends State<DesktopSignup> {
  final _signupFormKey = GlobalKey<FormState>();
  bool passswordVisible = false;
  bool confirmPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.yellow.shade300,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 400,
            child: Card(
              color: Colors.grey[100],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _signupFormKey,
                    child: Column(
                      spacing: 15,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Sign Up',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        AuthTextFormField(
                          controller: widget.nameController,
                          hintText: "Name",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Name is required";
                            }
                            if (value.length < 3) {
                              return "Name must be at least 3 characters";
                            }
                            return null;
                          },
                          prefixIcon: Icons.person,
                        ),
                        AuthTextFormField(
                          controller: widget.emailController,
                          hintText: "Email",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            }
                            if (!RegExp(Constantstrings.emailRegEx)
                                .hasMatch(value)) {
                              return "Invalid email";
                            }
                            return null;
                          },
                          prefixIcon: Icons.email,
                        ),
                        AuthTextFormField(
                          controller: widget.passwordController,
                          hintText: 'Password',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Password is Required';
                            }
                            return null;
                          },
                          prefixIcon: Icons.lock,
                          isObscure: !passswordVisible,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passswordVisible = !passswordVisible;
                              });
                            },
                            icon: Icon(
                              !passswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        AuthTextFormField(
                          controller: widget.confirmPasswordController,
                          hintText: 'Confirm Password',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Confirm Password is Required';
                            }
                            if (value != widget.passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          prefixIcon: Icons.lock_outlined,
                          isObscure: !confirmPasswordVisible,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                confirmPasswordVisible =
                                    !confirmPasswordVisible;
                              });
                            },
                            icon: Icon(
                              !confirmPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: AuthButton(
                            onPressed: () {},
                            widget: Text('Sign Up'),
                          ),
                        ),
                      ],
                    ),
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
