import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/cart/cart_cubit.dart';
import 'package:shop_app/blocs/toggle/toggle_cubit.dart';
import 'package:shop_app/models/dish.dart';
import 'package:shop_app/widgets/helper/app_error.dart';
import 'package:shop_app/widgets/helper/app_loading.dart';

class DishCard extends StatelessWidget {
  final Dish dish;
  const DishCard({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 16.0 / 9.0,
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromRGBO(248, 247, 245, 1),
                          ),
                          child: Image.network(
                            dish.image,
                          ),
                        ),
                      ),
                      Positioned(
                          top: 8,
                          right: 8,
                          child: Row(
                            children: [
                              BlocBuilder<ToggleCubit, bool>(
                                builder: (context, state) {
                                  return Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color.fromRGBO(255, 255, 255, 1),
                                    ),
                                    child: IconButton(
                                      onPressed: context.read<ToggleCubit>().toggle,
                                      icon: state
                                          ? const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                              size: 20,
                                            )
                                          : const Icon(
                                              Icons.favorite_border,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    dish.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
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
                  ),
                ],
              ),
              content: SizedBox(
                height: 100,
                child: SingleChildScrollView(
                  child: Text(
                    dish.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
              actions: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(51, 100, 224, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      cartCubit.add(dish);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Товар добавлен в корзину'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Добавить в корзину',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
              ),
              child: Image.network(
                errorBuilder: (context, error, stackTrace) {
                  return const AppError('Ошибка загрузки изображения');
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const AppLoading();
                },
                dish.image,
              ),
            ),
          ),
          Expanded(
            child: Text(
              dish.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
