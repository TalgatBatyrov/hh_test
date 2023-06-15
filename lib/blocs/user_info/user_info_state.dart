abstract class UserInfoState {}

class UserInformationInitial extends UserInfoState {}

class UserInformationLoading extends UserInfoState {}

class UserInformationLoaded extends UserInfoState {
  final String country;
  final String city;

  UserInformationLoaded(this.country, this.city);
}

class UserInformationError extends UserInfoState {
  final String message;

  UserInformationError(this.message);
}

extension UserInfoStateUnion on UserInfoState {
  T map<T>({
    required T Function(UserInformationInitial) initial,
    required T Function(UserInformationLoading) loading,
    required T Function(UserInformationLoaded) loaded,
    required T Function(UserInformationError) error,
  }) {
    if (this is UserInformationInitial) {
      return initial(this as UserInformationInitial);
    }
    if (this is UserInformationLoading) {
      return loading(this as UserInformationLoading);
    }
    if (this is UserInformationLoaded) {
      return loaded(this as UserInformationLoaded);
    }
    if (this is UserInformationError) {
      return error(this as UserInformationError);
    }
    throw AssertionError('Union does not match any possible values');
  }
}
