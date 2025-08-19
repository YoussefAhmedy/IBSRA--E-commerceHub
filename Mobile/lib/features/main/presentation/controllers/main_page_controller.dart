import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique/features/cart/presentation/pages/cart_page.dart';
import 'package:unique/features/collections/presentation/pages/collections_page.dart';

class MainPageController extends GetxController {
  int currentIndex = 0;

  void toggleCurrentIndex(int index) {
    currentIndex = index;
    update();
  }

  Widget toggleCurrentPage() {
    switch (currentIndex) {
      case 0:
        return CollectionsPage();
      case 1:
        return Container(
          child: Center(
            child: Text('Search Page'),
          ),
        );
      case 2:
        return CartPage();
      default:
        return Container();
    }
  }
}
