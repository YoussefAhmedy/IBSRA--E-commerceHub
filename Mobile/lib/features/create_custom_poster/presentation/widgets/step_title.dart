import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/themes/app_colors.dart';
import '../controllers/create_poster_controller.dart';

class StepTitle extends StatelessWidget {
  const StepTitle({
    super.key,
    required this.index,
    required this.stepTitle,
  });

  final int index;
  final String stepTitle;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatePosterController>(
      init: CreatePosterController(),
      builder: (controller) => Text(
        stepTitle,
        style: TextStyle(
          fontSize: 10.5,
          color: controller.currentIndex > index
              ? Colors.green
              : controller.currentIndex == index
              ? AppColors.primaryColor
              : Color(0xFF717182),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
