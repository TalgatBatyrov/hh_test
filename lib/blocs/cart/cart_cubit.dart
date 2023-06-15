import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/dish.dart';

class CartCubit extends Cubit<List<Dish>> {
  CartCubit() : super([]);

  int get totalPrice {
    return state.fold<int>(
      0,
      (previousValue, element) => previousValue + element.price,
    );
  }

  void add(Dish dish) {
    final updatedCart = [...state, dish];
    emit(updatedCart);
  }

  void remove(Dish dish) {
    final updatedCart = [...state];
    updatedCart.remove(dish);
    emit(updatedCart);
  }
}
