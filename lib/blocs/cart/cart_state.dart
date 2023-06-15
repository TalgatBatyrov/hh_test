import '../../models/dish.dart';

abstract class CartState {
  const CartState();
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Dish> dishes;
  const CartLoaded(this.dishes);
}

class CartEmpty extends CartState {}

class CartError extends CartState {
  final String message;
  const CartError(this.message);
}
