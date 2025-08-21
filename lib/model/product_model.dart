import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class ProductModel {
  final String id;
  final String name;
  final double price;
  final String image;
  final String desc;
  List? sizes;
  List? colors;
  final bool isAvailable;
  bool isFavorite;
  bool isSelected;

  ProductModel(
      {required this.name,
      required this.price,
      required this.image,
      required this.desc,
      this.sizes,
      this.colors,
      required this.isAvailable,
      this.isSelected = false,
      this.isFavorite = false})
      : id = uuid.v4();
}
