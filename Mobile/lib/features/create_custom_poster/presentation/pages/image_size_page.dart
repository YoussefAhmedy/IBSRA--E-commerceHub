import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique/core/themes/app_colors.dart';
import 'package:unique/features/create_custom_poster/presentation/controllers/create_poster_controller.dart';

class ImageSizePage extends StatelessWidget {
  const ImageSizePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreatePosterController>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(21.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image Preview Container with Size-based Cropping
              GetBuilder<CreatePosterController>(
                builder: (controller) => Container(
                  padding: EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.5),
                    border: Border.all(color: Colors.black.withAlpha(26)),
                  ),
                  child: Column(
                    children: [
                      // Cropped Image Preview
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.5),
                        child: controller.selectedSizedIndex != -1
                            ? _buildCroppedImage(controller)
                            : _buildOriginalImage(controller),
                      ),
                      if (controller.selectedSizedIndex != -1) ...[
                        SizedBox(height: 14.0),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 12.0,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: AppColors.primaryColor.withAlpha(50),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.crop_free,
                                color: AppColors.primaryColor,
                                size: 16.0,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                'Preview cropped for ${controller.posterSizes[controller.selectedSizedIndex]['name']}',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: 21),

              // Size Selection Container
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
                      'Select Size',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 14.0),
                    SizedBox(
                      height: 300.0,
                      child: ListView.builder(
                        itemCount: controller.posterSizes.length,
                        itemBuilder: (context, index) {
                          final size = controller.posterSizes[index];
                          return GetBuilder<CreatePosterController>(
                            builder: (controller) => GestureDetector(
                              onTap: () {
                                controller.selectedSized =
                                    controller.posterSizes[index]['name'];
                                controller.selectedSizedPrice =
                                    (controller.posterSizes[index]['price']
                                            as num)
                                        .toInt();
                                controller.toggleSize(index);
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10.5),
                                width: double.infinity,
                                padding: EdgeInsets.all(14.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.5),
                                  color: controller.selectedSizedIndex == index
                                      ? AppColors.primaryColor.withAlpha(10)
                                      : null,
                                  border: Border.all(
                                    color:
                                        controller.selectedSizedIndex == index
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
                                              controller.selectedSizedIndex ==
                                                  index
                                              ? AppColors.primaryColor
                                              : Color(0xFF717182),
                                          width:
                                              controller.selectedSizedIndex ==
                                                  index
                                              ? 4
                                              : 1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.5),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            size['name'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            size['description'],
                                            style: TextStyle(
                                              fontSize: 12.25,
                                              color: Color(0xFF717182),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 8.0),
                                    Text(
                                      '\$${size['price']}',
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

              // Info Container
              Container(
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(10.5),
                  border: Border.all(
                    color: AppColors.primaryColor.withAlpha(50),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.primaryColor,
                      size: 17.5,
                    ),
                    SizedBox(width: 10.5),
                    Expanded(
                      child: Text(
                        'All posters printed at 300 DPI for crisp quality. Image will be automatically cropped to fit the selected size.',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 12.25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 21.0),

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: GetBuilder<CreatePosterController>(
                  builder: (controller) => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.selectedSizedIndex != -1
                          ? AppColors.primaryColor
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.5),
                      ),
                      elevation: 0.0,
                    ),
                    onPressed: controller.selectedSizedIndex != -1
                        ? () {
                            controller.pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        : null,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      child: Text(
                        controller.selectedSizedIndex != -1
                            ? 'Continue to Frame Selection'
                            : 'Select a Size to Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.25,
                        ),
                      ),
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

  // Build original image when no size is selected
  Widget _buildOriginalImage(CreatePosterController controller) {
    return Container(
      height: 250.0,
      width: double.infinity,
      child: Image.file(controller.imageFile!, fit: BoxFit.contain),
    );
  }

  // Build cropped image preview based on selected size
  Widget _buildCroppedImage(CreatePosterController controller) {
    final selectedSize = controller.posterSizes[controller.selectedSizedIndex];
    final aspectRatio = selectedSize['aspectRatio'] as double;

    return Container(
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: SizedBox(
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.file(
              controller.imageFile!,
              fit:
                  BoxFit.cover, // This crops the image to fill the aspect ratio
            ),
          ),
        ),
      ),
    );
  }
}
