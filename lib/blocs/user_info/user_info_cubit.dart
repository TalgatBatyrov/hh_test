import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shop_app/blocs/user_info/user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit() : super(UserInformationInitial()) {
    getUserLocation();
  }

  Future<void> getUserLocation() async {
    emit(UserInformationLoading());

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(UserInformationError('Служба геолокации выключена.'));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      emit(UserInformationError('Нет доступа к геолокации. Проверьте разрешения.'));
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        emit(UserInformationError('Нет доступа к геолокации. Проверьте разрешения.'));
        return;
      }
    }

    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      emit(UserInformationError('Не удалось получить местоположение.'));
      return;
    }

    List<Placemark> placemarks;
    try {
      placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
    } catch (e) {
      emit(UserInformationError('Не удалось получить информацию о местоположении.'));
      return;
    }

    if (placemarks.isNotEmpty) {
      final country = placemarks.first.country ?? '';
      final city = placemarks.first.locality ?? '';

      emit(UserInformationLoaded(country, city));
    } else {
      emit(UserInformationError('Информация о местоположении не найдена.'));
    }
  }
}
