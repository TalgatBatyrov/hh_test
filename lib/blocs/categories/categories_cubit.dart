import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/categories/categories_state.dart';
import 'package:shop_app/models/category.dart';

import '../../data/repository/app_repository.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final AppRepository _repo;
  CategoriesCubit(this._repo) : super(CategoriesLoading()) {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      emit(CategoriesLoading());
      final response = await _repo.fetchCategories();
      final categories = response.map((e) => Category.fromJson(e)).toList();

      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(const CategoriesError('Ошибка при загрузке категорий'));
    }
  }
}
