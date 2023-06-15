import 'package:shop_app/models/dish.dart';

abstract class DishesState {
  const DishesState();
}

class DishesInitial extends DishesState {}

class DishesLoading extends DishesState {}

class DishesLoaded extends DishesState {
  final List<Dish> dishes;
  const DishesLoaded(this.dishes);
}

class DishesError extends DishesState {
  final String message;
  const DishesError(this.message);
}

extension DishesStateUnion on DishesState {
  T map<T>({
    required T Function(DishesInitial) initial,
    required T Function(DishesLoading) loading,
    required T Function(DishesLoaded) loaded,
    required T Function(DishesError) error,
  }) {
    if (this is DishesInitial) {
      return initial(this as DishesInitial);
    }
    if (this is DishesLoading) {
      return loading(this as DishesLoading);
    }
    if (this is DishesLoaded) {
      return loaded(this as DishesLoaded);
    }
    if (this is DishesError) {
      return error(this as DishesError);
    }
    throw AssertionError('Union does not match any possible values');
  }
}
