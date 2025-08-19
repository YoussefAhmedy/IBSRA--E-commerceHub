import 'package:flutter/material.dart';
import 'package:unique/features/auth/pages/login_page.dart';
import 'package:unique/features/auth/widgets/custom_button.dart';
import 'package:unique/features/auth/widgets/custom_icon.dart';
import 'package:unique/features/auth/widgets/signup_form.dart';
import 'package:unique/features/main/presentation/pages/main_page.dart';

class SignupPageBody extends StatefulWidget {
  const SignupPageBody({super.key});

  @override
  State<SignupPageBody> createState() => _SignupPageBodyState();
}

class _SignupPageBodyState extends State<SignupPageBody> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
              child: Column(
                children: [
                  CustomIcon(icon: Icons.person_add_outlined),
                  SizedBox(height: 10),
                  Text("Create your account", style: TextStyle(fontSize: 24)),
                  Text(
                    "Join Unique and start creating beatiful posters",
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
                          SignupForm(),
                          SizedBox(height: 25),
                          CustomButton(
                            buttonName: 'Create Account',
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
                              Text("Already have an account?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Sign in",
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
