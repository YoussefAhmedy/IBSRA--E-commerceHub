import 'package:flutter/material.dart';
import 'package:unique/features/auth/widgets/custom_text_field.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Full Name"),
        SizedBox(height: 10),
        CustomTextField(
          hintText: 'Enter your full name',
          keyboardType: TextInputType.text,
        ),
        SizedBox(height: 12),
        Text("Email Address"),
        SizedBox(height: 10),
        CustomTextField(
          hintText: 'Enter your email address',
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 12),
        Text("Password"),
        SizedBox(height: 10),
        CustomTextField(
          hintText: 'Enter your password',
          keyboardType: TextInputType.visiblePassword,
        ),
        SizedBox(height: 12),
        Text("Confirm Password"),
        SizedBox(height: 10),
        CustomTextField(
          hintText: "Confirm your password",
          keyboardType: TextInputType.visiblePassword,
        ),
      ],
    );
  }
}
