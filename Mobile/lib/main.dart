import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique/core/bindings/app_bindings.dart';
import 'package:unique/core/themes/app_theme.dart';
import 'package:unique/core/utils/get_pages.dart';
import 'package:unique/features/auth/pages/login_page.dart';
import 'package:unique/features/cart/presentation/pages/cart_page.dart';
import 'package:unique/features/main/presentation/pages/main_page.dart';
import 'package:unique/features/profile/presentation/pages/change_pass_page.dart';
import 'package:unique/features/profile/presentation/pages/profile_page.dart';

void main() {
  runApp(const UniqueApp());
}

class UniqueApp extends StatelessWidget {
  const UniqueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialBinding: AppBindings(),
      getPages: getPages,
      home: LoginPage(),
    );
  }
}
