import '../../models/category.dart';

abstract class CategoriesState {
  const CategoriesState();
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<Category> categories;
  const CategoriesLoaded(this.categories);
}

class CategoriesError extends CategoriesState {
  final String message;
  const CategoriesError(this.message);
}

extension CategoriesStateUnion on CategoriesState {
  T map<T>({
    required T Function(CategoriesInitial) initial,
    required T Function(CategoriesLoading) loading,
    required T Function(CategoriesLoaded) loaded,
    required T Function(CategoriesError) error,
  }) {
    if (this is CategoriesInitial) {
      return initial(this as CategoriesInitial);
    }
    if (this is CategoriesLoading) {
      return loading(this as CategoriesLoading);
    }
    if (this is CategoriesLoaded) {
      return loaded(this as CategoriesLoaded);
    }
    if (this is CategoriesError) {
      return error(this as CategoriesError);
    }
    throw AssertionError('Union does not match any possible values');
  }
}
