import 'package:blinkit_admin/features/auth/presentation/widgets/auth_button.dart';
import 'package:blinkit_admin/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white12, Colors.amber],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                    flex: 8,
                    child: Form(
                      key: _loginFormKey,
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: Center(
                          child: SizedBox(
                            width: 400,
                            height: 400,
                            child: Column(
                              spacing: 25,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome Back",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Login to your account",
                                    ),
                                  ],
                                ),
                                AuthTextFormField(
                                  hintText: "Email",
                                  controller: widget.emailController,
                                  prefixIcon: Icons.email,
                                ),
                                AuthTextFormField(
                                  hintText: "Password",
                                  controller: widget.passwordController,
                                  isObscure: true,
                                  prefixIcon: Icons.lock,
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.visibility_off),
                                  ),
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
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
