import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique/core/themes/app_colors.dart';
import 'package:unique/features/create_custom_poster/presentation/controllers/create_poster_controller.dart';

class ImageFramePage extends StatelessWidget {
  const ImageFramePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreatePosterController>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(21.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image preview with selected frame
              Container(
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.5),
                  border: Border.all(color: Colors.black.withAlpha(26)),
                ),
                child: Column(
                  children: [
                    GetBuilder<CreatePosterController>(
                      builder: (controller) => Container(
                        padding: EdgeInsets.all(8.0),
                        decoration:
                            controller.selectedFrameIndex != -1 &&
                                controller.selectedFrameIndex >= 0
                            ? BoxDecoration(
                                color:
                                    controller.frameOptions[controller
                                        .selectedFrameIndex]['color'],
                                borderRadius: BorderRadius.circular(14.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              )
                            : null,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            controller.selectedFrameIndex != -1 &&
                                    controller.selectedFrameIndex >= 0
                                ? 10.5
                                : 14.5,
                          ),
                          child: Image.file(
                            controller.imageFile!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    GetBuilder<CreatePosterController>(
                      builder: (controller) => Text(
                        controller.selectedFrameIndex >= 0
                            ? '12x16" with ${controller.frameOptions[controller.selectedFrameIndex]['name']}'
                            : '12x16" with No Frame',
                        style: TextStyle(
                          color: Color(0xFF717182),
                          fontSize: 12.25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 21),

              // Frame selection container
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.5),
                  border: Border.all(color: Colors.black.withAlpha(26)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Frame',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 14.0),

                    // No Frame Option
                    GestureDetector(
                      onTap: () {
                        controller.selectedFramePrice = 0;
                        controller.selectedFrameColor = 'No Frame';
                        controller.toggleFrame(-1);
                      },

                      child: GetBuilder<CreatePosterController>(
                        builder: (controller) => Container(
                          margin: EdgeInsets.only(bottom: 10.5),
                          width: double.infinity,
                          padding: EdgeInsets.all(14.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.5),
                            color: controller.selectedFrameIndex == null
                                ? AppColors.primaryColor.withAlpha(10)
                                : null,
                            border: Border.all(
                              color: controller.selectedFrameIndex == null
                                  ? AppColors.primaryColor
                                  : Colors.black.withAlpha(26),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 14.0,
                                width: 14.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: controller.selectedFrameIndex == -1
                                        ? AppColors.primaryColor
                                        : Color(0xFF717182),
                                    width: controller.selectedFrameIndex == -1
                                        ? 4
                                        : 1,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.5),
                              Container(
                                height: 35.0,
                                width: 35.0,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(3.5),
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                    style: BorderStyle.solid,
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  Icons.image_outlined,
                                  size: 20,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              SizedBox(width: 10.5),
                              Text(
                                'No Frame',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'Free',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Frame Options
                    SizedBox(
                      height:
                          320.0, // Increased height to accommodate all options
                      child: ListView.builder(
                        itemCount: controller.frameOptions.length,
                        itemBuilder: (context, index) {
                          final frame = controller.frameOptions[index];
                          return GestureDetector(
                            onTap: () {
                              controller.selectedFrameColor =
                                  controller.frameOptions[index]['name'];
                              controller.selectedFramePrice =
                                  (controller.frameOptions[index]['price']
                                          as num)
                                      .toInt();
                              controller.toggleFrame(index);
                            },
                            child: GetBuilder<CreatePosterController>(
                              builder: (controller) => Container(
                                margin: EdgeInsets.only(bottom: 10.5),
                                width: double.infinity,
                                padding: EdgeInsets.all(14.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.5),
                                  color: controller.selectedFrameIndex == index
                                      ? AppColors.primaryColor.withAlpha(10)
                                      : null,
                                  border: Border.all(
                                    color:
                                        controller.selectedFrameIndex == index
                                        ? AppColors.primaryColor
                                        : Colors.black.withAlpha(26),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 14.0,
                                      width: 14.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color:
                                              controller.selectedFrameIndex ==
                                                  index
                                              ? AppColors.primaryColor
                                              : Color(0xFF717182),
                                          width:
                                              controller.selectedFrameIndex ==
                                                  index
                                              ? 4
                                              : 1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.5),
                                    Container(
                                      height: 35.0,
                                      width: 35.0,
                                      decoration: BoxDecoration(
                                        color: frame['color'],
                                        borderRadius: BorderRadius.circular(
                                          3.5,
                                        ),
                                        border: frame['color'] == Colors.white
                                            ? Border.all(
                                                color: Colors.grey.shade300,
                                                width: 1,
                                              )
                                            : null,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ),
                                            blurRadius: 2,
                                            offset: Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10.5),
                                    Expanded(
                                      child: Text(
                                        frame['name'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '\$${frame['price']}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 21.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.5),
                    ),
                    elevation: 0.0,
                  ),
                  onPressed: () => controller.pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  child: Text(
                    'Continue to Review',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
