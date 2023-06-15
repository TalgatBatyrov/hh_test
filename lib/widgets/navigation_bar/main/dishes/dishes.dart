import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/dishes/dishes_cubit.dart';
import 'package:shop_app/blocs/dishes/dishes_state.dart';
import 'package:shop_app/widgets/navigation_bar/main/dishes/dish_card.dart';

import '../../../helper/app_error.dart';
import '../../../helper/app_loading.dart';

class Dishes extends StatefulWidget {
  final String categoryName;
  const Dishes({super.key, required this.categoryName});

  @override
  State<Dishes> createState() => _DishesState();
}

class _DishesState extends State<Dishes> {
  final tegs = [
    'Все меню',
    'Салаты',
    'С рисом',
    'С рыбой',
  ];
  List<String> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName, style: const TextStyle(fontSize: 18)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(backgroundImage: AssetImage('assets/images/user.png')),
          )
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: tegs
                  .map(
                    (e) => TextButton(
                      onPressed: () {
                        if (selectedTags.contains(e)) {
                          setState(() {
                            selectedTags.remove(e);
                          });
                        } else {
                          setState(() {
                            selectedTags.add(e);
                          });
                        }
                        context.read<DishesCubit>().filterDishes(selectedTags);
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          selectedTags.contains(e) ? const Color.fromRGBO(51, 100, 224, 1) : Colors.grey[200],
                        ),
                      ),
                      child: Text(
                        e,
                        style: TextStyle(
                          color: selectedTags.contains(e) ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<DishesCubit, DishesState>(
                builder: (context, state) {
                  return state.map(
                    initial: (_) => const AppLoading(),
                    loading: (_) => const AppLoading(),
                    loaded: (loadedState) {
                      final dishes = loadedState.dishes;
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: dishes.length,
                        itemBuilder: (context, index) {
                          final dish = dishes[index];
                          return DishCard(dish: dish);
                        },
                      );
                    },
                    error: (errorState) => AppError(errorState.message),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
