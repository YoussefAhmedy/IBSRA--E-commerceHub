import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique/core/constants/app_route.dart';
import 'package:unique/core/themes/app_colors.dart';
import 'package:unique/features/create_custom_poster/presentation/controllers/create_poster_controller.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreatePosterController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Success Icon
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F7EE),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Color(0xFF2EB872),
                  size: 50,
                ),
              ),

              const SizedBox(height: 20),

              // Title
              const Text(
                "Payment Successful",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle
              const Text(
                "Your order #12345 has been placed successfully.\nYou will receive a confirmation email shortly.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF717182),
                ),
              ),

              const SizedBox(height: 25),

              // Order Summary Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withAlpha(21)),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    _summaryRow("Estimated Delivery", "Aug 18 - Aug 21"),
                    const Divider(),
                    _summaryRow(
                      "Total Amount",
                      "\$${controller.calculateTotalPrice() + controller.deliveryPrice}",
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 3),

              // Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "View Order",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(color: Colors.black.withAlpha(21)),
                  ),
                  onPressed: () => Get.offAllNamed(AppRoute.mainPage),
                  child: const Text(
                    "Continue Shopping",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 14, color: Colors.black)),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
