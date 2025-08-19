import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique/features/create_custom_poster/presentation/pages/create_custom_poster_page.dart';

import '../../../../core/themes/app_colors.dart';
import '../controllers/create_poster_controller.dart';

class StepWidget extends StatelessWidget {
  const StepWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<CreatePosterController>(
        init: CreatePosterController(),
        builder: (controller) => Row(
          children: [
            StepItem(controller: controller, index: index),
            SizedBox(width: 4),
            StepDivider(index: index, controller: controller),
            SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}

class StepDivider extends StatelessWidget {
  const StepDivider({
    super.key,
    required this.index,
    required this.controller,
  });

  final CreatePosterController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 1.75,
      width: (MediaQuery.of(context).size.width - 64 - 14 * 4 - 8 * 3) / 4,
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: controller.currentIndex > index
            ? Colors.green
            : controller.currentIndex == index
            ? AppColors.primaryColor
            : Color(0xFFececf0),
      ),
    );
  }
}
