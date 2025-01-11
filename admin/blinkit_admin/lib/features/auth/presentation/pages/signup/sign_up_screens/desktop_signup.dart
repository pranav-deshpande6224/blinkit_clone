import 'package:blinkit_admin/core/constants/constant_strings.dart';
import 'package:blinkit_admin/features/auth/presentation/widgets/auth_button.dart';
import 'package:blinkit_admin/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:blinkit_admin/features/auth/presentation/widgets/gradient_container.dart';
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
  bool isPasswordContainEightChar = false;
  bool isPasswordContainUppercase = false;
  bool isPasswordCOntainNumber = false;
  bool isPasswordContainSpecialChar = false;
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final RegExp uppercaseRegExp = RegExp(r'[A-Z]');
  final RegExp numberRegExp = RegExp(r'[0-9]');
  final RegExp specialCharacterRegExp = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  void changeStateOfPassword(String value) {
    setState(() {
      isPasswordContainEightChar = value.length >= 8;
      isPasswordContainUppercase = uppercaseRegExp.hasMatch(value);
      isPasswordCOntainNumber = numberRegExp.hasMatch(value);
      isPasswordContainSpecialChar = specialCharacterRegExp.hasMatch(value);
    });
  }

  Widget strongPassword() {
    return Column(
      children: [
        Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: isPasswordContainEightChar
                    ? const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green,
                        size: 18,
                      )
                    : null,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Contain Atleast 8 Characters!',
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: isPasswordContainUppercase
                    ? const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green,
                        size: 18,
                      )
                    : null,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Contain 1 Uppercase Letter',
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: isPasswordCOntainNumber
                    ? const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green,
                        size: 18,
                      )
                    : null,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Contain 1 Number',
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: isPasswordContainSpecialChar
                    ? const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green,
                        size: 18,
                      )
                    : null,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Contain 1 Special Character',
            )
          ],
        )
      ],
    );
  }

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
                          focusNode: _nameFocusNode,
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
                          focusNode: _emailFocusNode,
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
                          focusNode: _passwordFocusNode,
                          controller: widget.passwordController,
                          hintText: 'Password',
                          onChanged: (p0) {
                            changeStateOfPassword(p0);
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter Password';
                            } else if (value.trim().length < 8) {
                              return 'Password must contain atleast 8 characters';
                            } else if (!uppercaseRegExp.hasMatch(value)) {
                              return 'Password should be atleast 1 uppercase character';
                            } else if (!numberRegExp.hasMatch(value)) {
                              return 'Password should be atleast 1 Number';
                            } else if (!specialCharacterRegExp
                                .hasMatch(value)) {
                              return 'Password should be atleast 1 Special Character';
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
                        strongPassword(),
                        AuthTextFormField(
                          focusNode: _confirmPasswordFocusNode,
                          controller: widget.confirmPasswordController,
                          hintText: 'Confirm Password',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter Confirm Password';
                            }
                            if (value != widget.passwordController.text) {
                              return 'Password does not match';
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
                            onPressed: () {
                              if (!_signupFormKey.currentState!.validate()) {
                                return;
                              }
                            },
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
