import 'package:blinkit_admin/core/constants/constant_strings.dart';
import 'package:blinkit_admin/features/auth/presentation/cubit/password_cubit.dart';
import 'package:blinkit_admin/features/auth/presentation/widgets/auth_button.dart';
import 'package:blinkit_admin/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.yellow.shade300],
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
                      BlocBuilder<PasswordCubit, bool>(
                        builder: (context, state) {
                          return AuthTextFormField(
                            controller: widget.passwordController,
                            hintText: 'Password',
                            validator: (value) {},
                            prefixIcon: Icons.lock,
                            isObscure: !state ? true : false,
                            suffixIcon: IconButton(
                              onPressed: () {
                                context
                                    .read<PasswordCubit>()
                                    .changePasswordVisibility();
                              },
                              icon: Icon(
                                !state
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          );
                        },
                      ),
                      BlocBuilder<PasswordCubit, bool>(
                        builder: (context, state) {
                          return AuthTextFormField(
                            controller: widget.confirmPasswordController,
                            hintText: 'Confirm Password',
                            validator: (value) {},
                            prefixIcon: Icons.lock_outlined,
                            isObscure: !state ? true : false,
                            suffixIcon: IconButton(
                              onPressed: () {
                                context
                                    .read<PasswordCubit>()
                                    .changePasswordVisibility();
                              },
                              icon: Icon(
                                !state
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: AuthButton(
                          onPressed: () {},
                          text: 'Sign Up',
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
    );
  }
}
