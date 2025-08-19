import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique/core/constants/app_route.dart';
import 'package:unique/core/themes/app_colors.dart';
import 'package:unique/features/create_custom_poster/domain/entities/delivery_item_entity.dart';
import 'package:unique/features/create_custom_poster/presentation/controllers/create_poster_controller.dart';
import 'package:unique/features/create_custom_poster/presentation/pages/payment_success.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreatePosterController>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shipping Address',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 24.0),
                      CustomTextFormField(
                        title: 'Full Name',
                        hint: 'Ahmed Elhalabi',
                      ),
                      SizedBox(height: 14.0),
                      CustomTextFormField(
                        title: 'Address',
                        hint: '123 Main Street',
                      ),
                      SizedBox(height: 14.0),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              title: 'City',
                              hint: 'New York',
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Expanded(
                            child: CustomTextFormField(
                              title: 'ZIP Code',
                              hint: '10001',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.0),
                      CustomTextFormField(
                        title: 'Phone',
                        hint: '+1 (555) 123-4567',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 21.0),
                Container(
                  padding: EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shipping Address',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 24.0),
                      SizedBox(
                        height: 150.0,
                        child: ListView.builder(
                          itemCount: controller.deliveryOptions.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.5),
                              child: GetBuilder<CreatePosterController>(
                                builder: (controller) => GestureDetector(
                                  onTap: () =>
                                      controller.toggleDeliveryPrice(index),
                                  child: DeliveryOptionItem(
                                    isSelected:
                                        controller.selectedDeliveryPrice ==
                                        index,
                                    deliveryItemEntity:
                                        controller.deliveryOptions[index],
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
                Container(
                  padding: EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment Method',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 24.0),
                      CustomTextFormField(
                        title: 'Card Number',
                        hint: '1234 5678 9012 3456',
                      ),
                      SizedBox(height: 14.0),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              title: 'Expiry Date',
                              hint: 'MM/YY',
                            ),
                          ),
                          SizedBox(width: 12.0),
                          Expanded(
                            child: CustomTextFormField(
                              title: 'CVV',
                              hint: '123',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 21.0),
                Container(
                  padding: EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.1)),
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
                            'Custom Poster x${controller.numberOfCopies}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.25,
                            ),
                          ),
                          Text(
                            '\$${controller.calculateTotalPrice()}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.25,
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.25,
                            ),
                          ),
                          Text(
                            '\$${controller.calculateTotalPrice()}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.25,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shipping',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.25,
                            ),
                          ),
                          GetBuilder<CreatePosterController>(
                            builder: (controller) => Text(
                              '\$${controller.deliveryPrice}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.25,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.75,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GetBuilder<CreatePosterController>(
                            builder: (controller) => Text(
                              '\$${controller.calculateTotalPrice() + controller.deliveryPrice}',
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
                    onPressed: () => Get.toNamed(AppRoute.paymentSuccessPage),
                    child: GetBuilder<CreatePosterController>(
                      builder: (controller) => Text(
                        'Pay \$${controller.calculateTotalPrice() + controller.deliveryPrice} with Card',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.25,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DeliveryOptionItem extends StatelessWidget {
  const DeliveryOptionItem({
    super.key,
    required this.deliveryItemEntity,
    required this.isSelected,
  });

  final DeliveryItemEntity deliveryItemEntity;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor.withAlpha(20) : null,
        border: Border.all(
          color: isSelected
              ? AppColors.primaryColor
              : Color.fromRGBO(0, 0, 0, 0.1),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.5),
      ),
      padding: EdgeInsets.all(14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                deliveryItemEntity.title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: Colors.black,
                ),
              ),
              Text(
                deliveryItemEntity.subtitle,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.25,
                  color: Color.fromRGBO(113, 113, 130, 1),
                ),
              ),
            ],
          ),
          Text(
            '\$${deliveryItemEntity.price}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.title,
    required this.hint,
  });

  final String title;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12.25,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 40,
          child: TextFormField(
            cursorColor: AppColors.primaryColor,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromRGBO(243, 243, 245, 1),
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                height: 1.3,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.5),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.5),
                borderSide: BorderSide(
                  color: AppColors.primaryColor,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
