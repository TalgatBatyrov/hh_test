import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/categories/categories_cubit.dart';
import 'package:shop_app/blocs/categories/categories_state.dart';
import 'package:shop_app/widgets/helper/app_error.dart';
import 'package:shop_app/widgets/helper/app_loading.dart';

import 'category_card.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => const AppLoading(),
            loading: (_) => const AppLoading(),
            loaded: (loadedState) {
              final categories = loadedState.categories;
              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = loadedState.categories[index];
                  return CategoryCard(category: category);
                },
              );
            },
            error: (errorState) => AppError(errorState.message),
          );
        },
      ),
    );
  }
}
