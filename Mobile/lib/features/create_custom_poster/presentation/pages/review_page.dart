import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique/core/constants/app_route.dart';
import 'package:unique/core/themes/app_colors.dart';
import 'package:unique/features/create_custom_poster/presentation/controllers/create_poster_controller.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreatePosterController>();
    return Padding(
      padding: const EdgeInsets.all(21.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.5),
                border: Border.all(color: Colors.black.withAlpha(26)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.5),
                      child: Image.file(
                        controller.imageFile!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'High-resolution print with premium quality materials',
                    style: TextStyle(
                      color: Color(0xFF717182),
                      fontSize: 12.25,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 21.0),
            Container(
              padding: EdgeInsets.all(21.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.5),
                border: Border.all(color: Colors.black.withAlpha(26)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Summary',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Size: ${controller.selectedSized} with ${controller.selectedFrameColor}',
                        style: TextStyle(
                          color: Color(0xFF717182),
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        '\$${controller.selectedFramePrice + controller.selectedSizedPrice}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Number of copies: ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.75,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: CircleBorder(),
                              side: BorderSide(color: Color(0xFFe5e7eb)),
                            ),
                            onPressed: () =>
                                controller.decreaseNumberOfCopies(),
                            child: Icon(
                              Icons.remove,
                              size: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          GetBuilder<CreatePosterController>(
                            builder: (controller) => Text(
                              controller.numberOfCopies.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: CircleBorder(),
                              side: BorderSide(color: Color(0xFFe5e7eb)),
                            ),
                            onPressed: () =>
                                controller.increaseNumberOfCopies(),
                            child: Icon(
                              Icons.add,
                              size: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.75,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GetBuilder<CreatePosterController>(
                        builder: (controller) => Text(
                          '\$${controller.calculateTotalPrice()}',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 15.75,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
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
                onPressed: () => Get.toNamed(AppRoute.checkOutPage),
                child: GetBuilder<CreatePosterController>(
                  builder: (controller) => Text(
                    'Buy Now - \$${controller.calculateTotalPrice()}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.25,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.5),
                  ),
                  side: BorderSide(color: Colors.black.withAlpha(21)),
                  elevation: 0.0,
                ),
                onPressed: () {},
                child: Text(
                  'Add to Cart',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
