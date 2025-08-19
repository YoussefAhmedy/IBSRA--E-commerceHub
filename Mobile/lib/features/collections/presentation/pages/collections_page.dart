import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique/core/constants/app_route.dart';
import 'package:unique/core/themes/app_colors.dart';
import 'package:unique/core/themes/app_decoratons.dart';
import 'package:unique/core/themes/app_text_styles.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoute.createCustomPoster),
        shape: CircleBorder(),
        elevation: 0.0,
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 64.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 21.0),
                      height: 211.0,
                      width: double.infinity,
                      decoration: AppDecorations.homePageHeroDecoration,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            'Discover our curated collection of high-quality posters perfect for any space — from abstract art to nature photography. Find the perfect piece for your home or office.',
                            style: AppTextStyles.regular14,
                          ),
                          SizedBox(height: 14.0),
                          HeroButton(
                            onPressed: () =>
                                Get.toNamed(AppRoute.createCustomPoster),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 21.0),
                    Text(
                      'Explore by Style',
                      style: AppTextStyles.regular14.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 14.0),
                    SizedBox(
                      height: 38.5,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return FilterListItem(isSelected: false);
                        },
                      ),
                    ),
                    SizedBox(height: 21.0),
                  ],
                ),
              ),
              SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:
                      (MediaQuery.of(context).size.width / 2) / 400,
                ),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Get.toNamed(AppRoute.posterDetails),
                    child: Poster(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterListItem extends StatelessWidget {
  const FilterListItem({
    super.key,
    required this.isSelected,
  });

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.5),
      child: Chip(
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: isSelected
            ? AppColors.primaryColor
            : Color(0xFFececf0),
        label: Text(
          'Abstract',
          style: TextStyle(
            fontSize: 12.25,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Color(0xFF717182),
          ),
        ),
      ),
    );
  }
}

class HeroButton extends StatelessWidget {
  const HeroButton({
    super.key,
    required this.onPressed,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.5),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        'Create Custom Poster',
        style: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 12.0,
        ),
      ),
    );
  }
}

class Poster extends StatelessWidget {
  const Poster({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 1), // x=0, y=1
            blurRadius: 2, // matches "2px"
            spreadRadius: 0, // matches "0" in CSS
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
            child: SizedBox(
              height: 164.0,
              width: 164.0,
              child: Image.network(
                'http://localhost:3000/_next/image?url=https%3A%2F%2Fimages.unsplash.com%2Fphoto-1541961017774-22349e4a1262%3Fw%3D500%26h%3D600%26fit%3Dcrop&w=1200&q=75',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Abstract Geometric Art',
                  style: TextStyle(
                    color: Color.fromRGBO(31, 41, 55, 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$24.99',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    Chip(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      labelPadding: EdgeInsets.zero,
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: Color(0xFFF3F4F6),
                      label: Text(
                        'Small',
                        style: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  '30cm × 40cm',
                  style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12.0),
                ),
                SizedBox(height: 12.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Add to cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
