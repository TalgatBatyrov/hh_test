import 'package:equatable/equatable.dart';

class Dish extends Equatable {
  final int id;
  final String name;
  final int price;
  final int weight;
  final String description;
  final String image;
  final List<String> tegs;

  const Dish({
    required this.id,
    required this.name,
    required this.price,
    required this.weight,
    required this.description,
    required this.image,
    required this.tegs,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      weight: json['weight'],
      description: json['description'],
      image: json['image_url'],
      tegs: json['tegs'].cast<String>(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        weight,
        description,
        image,
        tegs,
      ];
}
