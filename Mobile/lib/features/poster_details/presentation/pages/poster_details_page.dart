import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique/core/entities/poster_entity.dart';
import 'package:unique/core/themes/app_colors.dart';
import 'package:unique/features/poster_details/presentation/controllers/poster_details_controller.dart';

class PosterDetailsPage extends StatelessWidget {
  const PosterDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PosterDetailsController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Poster Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: SizedBox(
                    height: 358,
                    width: double.infinity,
                    child: Image.network(
                      'http://localhost:3000/_next/image?url=https%3A%2F%2Fimages.unsplash.com%2Fphoto-1541961017774-22349e4a1262%3Fw%3D500%26h%3D600%26fit%3Dcrop&w=1200&q=75',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Text(
                      'Poster',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    CircleAvatar(
                      radius: 2.0,
                      backgroundColor: Color(0xFF6B7280),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'In Stock',
                      style: TextStyle(
                        color: Color(0xFF16A34A),
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Abstract Geometric Art',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  '\$24.99',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(height: 24.0),
                Text(
                  'Description',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Modern abstract geometric artwork perfect for contemporary spaces.',
                  style: TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 24.0),
                Text(
                  'Specifications',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 12.0),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFf9fafb),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Category:',
                            style: TextStyle(
                              color: Color(0xFF4b5563),
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            'Poster',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Print Quality:',
                            style: TextStyle(
                              color: Color(0xFF4b5563),
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            'Premium',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Paper Type:',
                            style: TextStyle(
                              color: Color(0xFF4b5563),
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            'High-Quality Matte',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.0),
                Text(
                  'Quantity',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: CircleBorder(),
                        side: BorderSide(color: Color(0xFFe5e7eb)),
                      ),
                      onPressed: () => controller.decreaseQuantity(),
                      child: Icon(
                        Icons.remove,
                        size: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 12.0),
                    GetBuilder<PosterDetailsController>(
                      builder: (controller) => Text(
                        controller.quantity.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.0),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: CircleBorder(),
                        side: BorderSide(color: Color(0xFFe5e7eb)),
                      ),
                      onPressed: () => controller.increaseQuantity(),
                      child: Icon(
                        Icons.add,
                        size: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Price:',
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      GetBuilder<PosterDetailsController>(
                        builder: (controller) => Text(
                          '\$${controller.calculateTotalPrice().toStringAsFixed(2)}',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: 48.0,
                  width: double.infinity,
                  child: GetBuilder<PosterDetailsController>(
                    builder: (controller) => ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0.0,
                      ),
                      onPressed: () => controller.addToCart(
                        PosterEntity(
                          price: 24.99,
                          id: 'poster-01',
                          title: 'Abstract Geometric Art',
                          size: 'small',
                          frame: 'Black',
                        ),
                      ),
                      label: Text(
                        controller.updateCart
                            ? 'Added to Cart!'
                            : 'Add to Cart',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                        ),
                      ),
                      icon: controller.updateCart
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                SizedBox(
                  height: 48.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0.0,
                    ),
                    onPressed: () {},
                    child: Text(
                      'Buy now',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFf9fafb),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shipping Information',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '• Free shipping on orders over \$100',
                        style: TextStyle(
                          color: Color(0xFF4b5563),
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        '• Standard delivery: 3-7 business days',
                        style: TextStyle(
                          color: Color(0xFF4b5563),
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        '• Express delivery available at checkout',
                        style: TextStyle(
                          color: Color(0xFF4b5563),
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        '• Ships within 1-2 business days',
                        style: TextStyle(
                          color: Color(0xFF4b5563),
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFf9fafb),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Return Policy',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '30-day return policy. Items must be in original condition. Custom orders may have different return terms.',
                        style: TextStyle(
                          color: Color(0xFF4b5563),
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Features',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12.0),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check, color: Colors.green, size: 16.0),
                        SizedBox(width: 8.0),
                        Text(
                          'High-resolution printing',
                          style: TextStyle(
                            color: Color(0xFF4b5563),
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.check, color: Colors.green, size: 16.0),
                        SizedBox(width: 8.0),
                        Text(
                          'Fade-resistant inks',
                          style: TextStyle(
                            color: Color(0xFF4b5563),
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.check, color: Colors.green, size: 16.0),
                        SizedBox(width: 8.0),
                        Text(
                          'Ready to hang',
                          style: TextStyle(
                            color: Color(0xFF4b5563),
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.check, color: Colors.green, size: 16.0),
                        SizedBox(width: 8.0),
                        Text(
                          'Multiple size options available',
                          style: TextStyle(
                            color: Color(0xFF4b5563),
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
