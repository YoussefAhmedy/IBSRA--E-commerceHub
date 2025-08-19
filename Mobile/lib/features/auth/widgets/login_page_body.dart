import 'package:flutter/material.dart';
import 'package:unique/features/auth/pages/signup_page.dart';
import 'package:unique/features/auth/widgets/custom_button.dart';
import 'package:unique/features/auth/widgets/custom_icon.dart';
import 'package:unique/features/auth/widgets/login_form.dart';
import 'package:unique/features/main/presentation/pages/main_page.dart';

import '../../../core/themes/app_colors.dart';

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({super.key});

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = true;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 100,
              ),
              child: Column(
                children: [
                  CustomIcon(icon: Icons.person_outline),
                  SizedBox(height: 16),
                  Text("Welcome back", style: TextStyle(fontSize: 24)),
                  Text(
                    "Sign in to your unique account",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    alignment: Alignment.center,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 0,
                          blurRadius: 8,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          LoginForm(),
                          Row(
                            children: [
                              Checkbox(
                                fillColor: WidgetStatePropertyAll<Color>(
                                  AppColors.primaryColor,
                                ),
                                checkColor: Colors.white,
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                              ),
                              Text("Remember me"),
                              Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forgot password?",
                                  style: TextStyle(color: Color(0xfff44865)),
                                ),
                              ),
                            ],
                          ),
                          CustomButton(
                            buttonName: 'Sign in',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainPage(),
                                ),
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have account?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SignupPage();
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  "Create account",
                                  style: TextStyle(color: Color(0xfff44865)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
