import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique/core/themes/app_colors.dart';
import 'package:unique/features/create_custom_poster/presentation/pages/image_frame_page.dart';
import 'package:unique/features/create_custom_poster/presentation/pages/image_size_page.dart';
import 'package:unique/features/create_custom_poster/presentation/pages/review_page.dart';
import 'package:unique/features/create_custom_poster/presentation/pages/upload_image_page.dart';
import '../controllers/create_poster_controller.dart';
import '../widgets/step_title.dart';
import '../widgets/step_widget.dart';

class CreateCustomPosterPage extends StatelessWidget {
  const CreateCustomPosterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreatePosterController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: GetBuilder<CreatePosterController>(
          builder: (controller) => Text(
            controller.toggleAppBarTitle(),
            style: TextStyle(fontSize: 14.0, color: Colors.black),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 21.0),
          onPressed: () => controller.toggleNavigation(),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              children: List.generate(
                4,
                (index) {
                  if (index != 3) {
                    return StepWidget(index: index);
                  } else {
                    return StepItem(
                      controller: controller,
                      index: index,
                    );
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 7.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                return GetBuilder<CreatePosterController>(
                  builder: (controller) => StepTitle(
                    index: index,
                    stepTitle: controller.steps[index],
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: (index) => controller.toggleCurrentPage(index),
              physics: NeverScrollableScrollPhysics(),
              children: [
                UploadImagePage(),
                ImageSizePage(),
                ImageFramePage(),
                ReviewPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StepItem extends StatelessWidget {
  const StepItem({
    super.key,
    required this.controller,
    required this.index,
  });

  final CreatePosterController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatePosterController>(
      builder: (controller) => CircleAvatar(
        backgroundColor: controller.currentIndex > index
            ? Colors.green
            : controller.currentIndex == index
            ? AppColors.primaryColor
            : Color(0xFFececf0),
        radius: 14.0,
        child: controller.currentIndex > index
            ? Icon(
                Icons.check,
                color: Colors.white,
                size: 14.0,
              )
            : Text(
                '${index + 1}',
                style: TextStyle(
                  fontSize: 12.25,
                  color: controller.currentIndex > index
                      ? Colors.white
                      : controller.currentIndex == index
                      ? Colors.white
                      : Color(0xFF717182),
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );
  }
}
