import 'package:flutter/material.dart';
import 'package:unique/features/auth/widgets/custom_text_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Email address"),
        SizedBox(height: 10),
        CustomTextField(
          hintText: 'Enter your email address',
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 12),
        Text("Password"),
        SizedBox(height: 10),
        CustomTextField(
          hintText: "Enter your password",
          keyboardType: TextInputType.visiblePassword,
        ),
      ],
    );
  }
}
