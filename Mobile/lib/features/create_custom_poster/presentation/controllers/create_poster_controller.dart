import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unique/features/create_custom_poster/domain/entities/delivery_item_entity.dart';

class CreatePosterController extends GetxController {
  File? imageFile;
  bool loading = false;

  late PageController pageController;

  int selectedSizedPrice = 0;
  int selectedFramePrice = 0;
  String selectedSized = '';
  String selectedFrameColor = '';
  late int deliveryPrice;

  int selectedDeliveryPrice = 0;

  void toggleDeliveryPrice(int index) {
    deliveryPrice = deliveryOptions[index].price;
    selectedDeliveryPrice = index;
    update();
  }

  int numberOfCopies = 1;

  int calculateTotalPrice() {
    return (selectedSizedPrice + selectedFramePrice) * numberOfCopies;
  }

  void increaseNumberOfCopies() {
    numberOfCopies++;
    calculateTotalPrice();
    update();
  }

  void decreaseNumberOfCopies() {
    if (numberOfCopies > 1) {
      numberOfCopies--;
      calculateTotalPrice();
      update();
    }
  }

  void toggleNavigation() {
    switch (currentIndex) {
      case 0:
        Get.back();
        break;
      case 1:
      case 2:
      case 3:
        pageController.previousPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        break;
    }
  }

  String toggleAppBarTitle() {
    switch (currentIndex) {
      case 0:
        return 'Create Custom Poster';
      case 1:
        return 'Choose Sized';
      case 2:
        return 'Choose Frame';
      case 3:
        return 'Review & Confirm';
      default:
        return 'Create Custom Poster';
    }
  }

  List<DeliveryItemEntity> deliveryOptions = [
    DeliveryItemEntity(
      title: 'Standard Delivery',
      subtitle: '5-7 business days',
      price: 5,
    ),
    DeliveryItemEntity(
      title: 'Express Delivery',
      subtitle: '2-3 business days',
      price: 12,
    ),
  ];

  List<String> steps = ['Upload', 'Size', 'Frame', 'Review'];
  final List<Map<String, dynamic>> frameOptions = const [
    {'name': 'Black Frame', 'color': Colors.black, 'price': 25},
    {'name': 'Red Frame', 'color': Colors.red, 'price': 25},
    {
      'name': 'Natural Frame',
      'color': Color(0xFFD2B48C), // Tan/beige color
      'price': 30,
    },
    {
      'name': 'Dark Frame',
      'color': Color(0xFF654321), // Dark brown
      'price': 35,
    },
  ];

  final List<Map<String, dynamic>> posterSizes = const [
    {
      'name': '8x10"',
      'description': 'Perfect for desk displays',
      'price': 25,
      'aspectRatio': 0.8, // 8/10
      'width': 8.0,
      'height': 10.0,
    },
    {
      'name': '11x14"',
      'description': 'Great for wall art',
      'price': 35,
      'aspectRatio': 0.786, // 11/14
      'width': 11.0,
      'height': 14.0,
    },
    {
      'name': '16x20"',
      'description': 'Perfect for living room',
      'price': 45,
      'aspectRatio': 0.8, // 16/20
      'width': 16.0,
      'height': 20.0,
    },
    {
      'name': '18x24"',
      'description': 'Large statement piece',
      'price': 55,
      'aspectRatio': 28 / 34, // 18/24
      'width': 18.0,
      'height': 24.0,
    },
  ];

  @override
  void onInit() {
    pageController = PageController();
    deliveryPrice = deliveryOptions[0].price;
    selectedSizedPrice = (posterSizes[0]['price'] as num).toInt();
    selectedFramePrice = (frameOptions[1]['price'] as num).toInt();
    selectedSized = posterSizes[0]['name'];
    selectedFrameColor = frameOptions[0]['name'];
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  int currentIndex = 0;
  int selectedSizedIndex = 0;
  int selectedFrameIndex = 0;

  void toggleCurrentPage(int index) {
    currentIndex = index;
    update();
  }

  void toggleSize(int index) {
    selectedSizedIndex = index;
    update();
  }

  void toggleFrame(int index) {
    selectedFrameIndex = index;
    update();
  }

  void pickImage() async {
    try {
      loading = true;
      update();
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      loading = false;
      update();
      if (image != null) {
        imageFile = File(image.path);
      }
    } catch (e) {
      log(e.toString());
      loading = false;
      update();
    }
  }
}
