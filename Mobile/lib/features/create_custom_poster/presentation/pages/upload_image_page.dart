import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique/core/themes/app_colors.dart';
import 'package:unique/features/create_custom_poster/presentation/controllers/create_poster_controller.dart';

class UploadImagePage extends StatelessWidget {
  const UploadImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreatePosterController>();

    return Padding(
      padding: const EdgeInsets.all(21.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: DottedBorder(
              options: RectDottedBorderOptions(
                dashPattern: [4, 4], // short dash, short gap
                strokeWidth: 2, // thin
                color: Colors.black.withAlpha(26), // light gray
              ),
              child: GetBuilder<CreatePosterController>(
                builder: (controller) => Container(
                  padding: EdgeInsets.all(28.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Color(0xffececf0).withAlpha(51),
                  ),
                  child: controller.imageFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(14.0),
                          child: Image.file(controller.imageFile!),
                        )
                      : Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xffececf0),
                              radius: 28.0,
                              child: Icon(
                                Icons.cloud_upload,
                                size: 28.0,
                                color: Color(0xFF717182),
                              ),
                            ),
                            SizedBox(height: 14.0),
                            Text(
                              'Upload your favorite image',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'JPG or PNG, up to 20MB',
                              style: TextStyle(
                                fontSize: 12.25,
                                color: Color(0xFF717182),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
          SizedBox(height: 21.0),
          SizedBox(
            width: double.infinity,
            child: GetBuilder<CreatePosterController>(
              builder: (controller) => controller.imageFile != null
                  ? SizedBox(
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
                          'Continue to Size Selection',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.25,
                          ),
                        ),
                      ),
                    )
                  : ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.5),
                        ),
                        elevation: 0.0,
                      ),
                      onPressed: () =>
                          controller.loading ? () {} : controller.pickImage(),
                      icon: controller.loading
                          ? null
                          : Icon(
                              Icons.image_outlined,
                              color: Colors.white,
                              size: 14.0,
                            ),
                      label: controller.loading
                          ? CupertinoActivityIndicator(color: Colors.white)
                          : Text(
                              'Choose from Gallery',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.25,
                              ),
                            ),
                    ),
            ),
          ),
          GetBuilder<CreatePosterController>(
            builder: (controller) => Visibility(
              visible: controller.imageFile != null ? false : true,
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.5),
                    ),
                    elevation: 0.0,
                  ),
                  onPressed: () {},
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.black,
                    size: 14.0,
                  ),
                  label: Text(
                    'Take a photo',
                    style: TextStyle(
                      color: Colors.black,
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
    );
  }
}
