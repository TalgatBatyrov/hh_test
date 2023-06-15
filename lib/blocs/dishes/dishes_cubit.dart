import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/app_repository.dart';
import '../../models/dish.dart';
import 'dishes_state.dart';

class DishesCubit extends Cubit<DishesState> {
  final AppRepository _repo;
  DishesCubit(this._repo) : super(DishesInitial()) {
    fetchDishes();
  }

  Future<void> fetchDishes() async {
    try {
      emit(DishesLoading());
      final response = await _repo.fetchDishes();
      final dishes = response.map((e) => Dish.fromJson(e)).toList();
      emit(DishesLoaded(dishes));
    } catch (e) {
      emit(DishesError(e.toString()));
    }
  }

  Future<void> filterDishes(List<String> selectedTags) async {
    try {
      emit(DishesLoading());
      final response = await _repo.fetchDishes();
      final dishes = response.map((e) => Dish.fromJson(e)).toList();
      if (selectedTags.isEmpty) {
        emit(DishesLoaded(dishes));
        return;
      }
      final filteredDishes = dishes
          .where(
            (dish) => selectedTags.any((tag) => dish.tegs.contains(tag)),
          )
          .toList();
      emit(DishesLoaded(filteredDishes));
    } catch (e) {
      emit(DishesError(e.toString()));
    }
  }
}
