import 'package:flutter/material.dart';

import '../../models/dish.dart';

class DishPriceWeight extends StatelessWidget {
  final Dish dish;
  const DishPriceWeight({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${dish.price} ₽ ',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '· ${dish.weight} г',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
