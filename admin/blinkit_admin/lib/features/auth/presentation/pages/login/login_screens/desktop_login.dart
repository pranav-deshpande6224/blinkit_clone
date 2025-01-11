import 'package:blinkit_admin/core/constants/constant_strings.dart';
import 'package:blinkit_admin/features/auth/presentation/all_blocs/bloc/auth_bloc.dart';
import 'package:blinkit_admin/features/auth/presentation/all_blocs/cubit/spinner_cubit.dart';
import 'package:blinkit_admin/features/auth/presentation/widgets/auth_button.dart';
import 'package:blinkit_admin/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _loginFormKey = GlobalKey<FormState>();
  final String emailRegExp = Constantstrings.emailRegEx;
  bool passswordVisible = false;
  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            context.read<SpinnerCubit>().hideSpinner();
            showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.warning, color: Colors.red),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(state.message),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Okay'),
                    ),
                  ],
                );
              },
            );
          } else if (state is AuthLoading) {
            context.read<SpinnerCubit>().showSpinner();
          } else if (state is AuthSuccess) {
            context.read<SpinnerCubit>().hideSpinner();
            context.replace('/dashboard');
          }
        },
        child: Row(
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
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: SizedBox(
                      width: 400,
                      child: SingleChildScrollView(
                        child: Form(
                          key: _loginFormKey,
                          child: Column(
                            spacing: 25,
                            mainAxisSize: MainAxisSize.min,
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
                                focusNode: _emailFocusNode,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AuthTextFormField(
                                    focusNode: _passwordFocusNode,
                                    hintText: "Password",
                                    controller: widget.passwordController,
                                    isObscure: !passswordVisible,
                                    prefixIcon: Icons.lock,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          passswordVisible = !passswordVisible;
                                        });
                                      },
                                      icon: Icon(!passswordVisible
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
                                width: double.infinity,
                                height: 50,
                                child: BlocBuilder<SpinnerCubit, bool>(
                                  builder: (context, state) {
                                    return AuthButton(
                                      widget: !state
                                          ? Text('Login')
                                          : CircularProgressIndicator.adaptive(
                                              strokeWidth: 1,
                                            ),
                                      onPressed: () {
                                        if (!_loginFormKey.currentState!
                                            .validate()) {
                                          return;
                                        }

                                        context.read<AuthBloc>().add(
                                              AuthLoginEvent(
                                                email:
                                                    widget.emailController.text,
                                                password: widget
                                                    .passwordController.text,
                                              ),
                                            );
                                      },
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: AuthButton(
                                  color: Colors.white,
                                  widget: Row(
                                    spacing: 10,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/g.svg',
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        'Continue with Google',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                  onPressed: () {},
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
