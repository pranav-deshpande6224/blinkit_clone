import 'package:blinkit_admin/core/constants/constant_strings.dart';
import 'package:blinkit_admin/core/reusable_widgets/reusable_expanded.dart';
import 'package:blinkit_admin/features/auth/presentation/cubit/password_cubit.dart';
import 'package:blinkit_admin/features/auth/presentation/widgets/auth_button.dart';
import 'package:blinkit_admin/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DesktopLogin extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const DesktopLogin(
      {required this.emailController,
      required this.passwordController,
      super.key});

  @override
  State<DesktopLogin> createState() => _DesktopLoginState();
}

class _DesktopLoginState extends State<DesktopLogin> {
  final _loginFormKey = GlobalKey<FormState>();
  final String emailRegExp = Constantstrings.emailRegEx;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 6,
            child: Image.asset(
              height: double.infinity,
              Constantstrings.blinkitLogo,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border(
                  left: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: [
                  reusableExpanded(child: SizedBox()),
                  Expanded(
                    flex: 8,
                    child: Form(
                      key: _loginFormKey,
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: Center(
                          child: SizedBox(
                            width: 400,
                            child: Column(
                              spacing: 25,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Constantstrings.welcome,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                     Constantstrings.loginAccount,
                                    ),
                                  ],
                                ),
                                AuthTextFormField(
                                  hintText: "Email",
                                  controller: widget.emailController,
                                  prefixIcon: Icons.email,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Email is required";
                                    }
                                    if (!RegExp(emailRegExp).hasMatch(value)) {
                                      return "Enter a valid email";
                                    }
                                    return null;
                                  },
                                ),
                                Column(
                                  children: [
                                    BlocBuilder<PasswordCubit, bool>(
                                      builder: (context, state) {
                                        return AuthTextFormField(
                                          hintText: "Password",
                                          controller: widget.passwordController,
                                          isObscure: !state ? true : false,
                                          prefixIcon: Icons.lock,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              context
                                                  .read<PasswordCubit>()
                                                  .changePasswordVisibility();
                                            },
                                            icon: Icon(!state
                                                ? Icons.visibility_off
                                                : Icons.visibility),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return "Password is required";
                                            }
                                            return null;
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Spacer(),
                                        TextButton(
                                          onPressed: () {
                                            context.pushNamed('fp');
                                          },
                                          child: Text(
                                            "Forgot Password?",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: AuthButton(
                                    text: "Login",
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: Theme.of(context)
                                        .elevatedButtonTheme
                                        .style!
                                        .copyWith(
                                          shape: WidgetStateProperty.all(
                                            RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 0.5,
                                                color: Colors.blueGrey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                            Colors.white,
                                          ),
                                        ),
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/google.png",
                                          height: 40,
                                          width: 40,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Continue with Google",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Don\'t have an account?'),
                                    TextButton(
                                      onPressed: () {
                                        context.pushNamed('signup');
                                      },
                                      child: Text(
                                        'Sign up',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  reusableExpanded(child: SizedBox())
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
