import 'package:dio/dio.dart';
import '../api/app_api.dart';

class AppRepository {
  final dio = Dio();

  Future<List<dynamic>> fetchCategories() async {
    final response = await dio.get(AppApi.categories);
    // буква 'с' в categories - кириллица :)
    final categories = response.data['сategories'];
    final result = categories as List<dynamic>;
    return result;
  }

  Future<List<dynamic>> fetchDishes() async {
    final response = await dio.get(AppApi.dishes);
    final dishes = response.data['dishes'];
    return dishes as List<dynamic>;
  }
}
