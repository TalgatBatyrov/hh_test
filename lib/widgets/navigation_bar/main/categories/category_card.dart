import 'package:flutter/material.dart';
import 'package:shop_app/widgets/helper/app_error.dart';
import 'package:shop_app/widgets/navigation_bar/main/dishes/dishes.dart';

import '../../../../models/category.dart';
import '../../../helper/app_loading.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return Dishes(categoryName: category.name);
              },
            ),
          );
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.network(
              errorBuilder: (context, error, stackTrace) {
                return const AppError('Ошибка загрузки изображения');
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const AppLoading();
              },
              category.imageUrl,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 12,
              left: 16,
              child: Text(
                category.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
