import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/cart/cart_cubit.dart';
import 'package:shop_app/models/dish.dart';

import '../../helper/app_empty.dart';
import '../../helper/dish_price_weight.dart';
import '../main/categories/user_info.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    return SafeArea(
      minimum: const EdgeInsets.only(top: 45),
      child: Scaffold(
        appBar: const UserInfo(),
        body: BlocBuilder<CartCubit, List<Dish>>(
          builder: (context, list) {
            final uniqueItems = list.toSet().toList();
            if (list.isEmpty) return const AppEmpty(title: 'Нет товаров в корзине');
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: uniqueItems.length,
                    itemBuilder: (context, index) {
                      final dish = uniqueItems[index];
                      final count = list.where((element) => element == dish).length;
                      return ListTile(
                        leading: Image.network(dish.image),
                        title: Text(dish.name, style: const TextStyle(fontSize: 14)),
                        subtitle: DishPriceWeight(dish: dish),
                        trailing: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(239, 238, 236, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove, size: 20),
                                onPressed: () {
                                  cartCubit.remove(dish);
                                },
                              ),
                              Text(count.toString(), style: const TextStyle(fontSize: 14)),
                              IconButton(
                                icon: const Icon(Icons.add, size: 20),
                                onPressed: () {
                                  cartCubit.add(dish);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(51, 100, 224, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Оплатить ${cartCubit.totalPrice} ₽',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }
}
