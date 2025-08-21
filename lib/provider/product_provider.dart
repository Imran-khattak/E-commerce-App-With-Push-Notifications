import 'package:flutter/material.dart';

import 'package:notifications/model/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final List<ProductModel> _shirts = [
    ProductModel(
      name: "Black T-Shirt",
      price: 50,
      image: 'assets/black-shirt.jpg',
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [Colors.black, Color(0xffB7B3AF), Color(0xff5983C0)],
      isAvailable: true,
    ),
    ProductModel(
      name: "Black Jeans",
      price: 79,
      image: "assets/black.png",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [Colors.black, Color(0xffB7B3AF), Color(0xff5983C0)],
      isAvailable: true,
    ),
    ProductModel(
      name: "Printed T-Shirt",
      price: 60,
      image: "assets/printed_casual_shirt.png",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [Colors.black, Color(0xffB7B3AF), Color(0xff5983C0)],
      isAvailable: false,
    ),
    ProductModel(
      name: "Summer T-Shirt",
      price: 60,
      image: "assets/summer_t_shirt.jpg",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [Colors.black, Color(0xffB7B3AF), Color(0xff5983C0)],
      isAvailable: true,
    ),
    ProductModel(
      name: "White Jeans",
      price: 79,
      image: "assets/white_jeans.jpg",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [Colors.black, Color(0xffB7B3AF), Color(0xff5983C0)],
      isAvailable: false,
    ),
    ProductModel(
      name: "Navy Blue Shirt",
      price: 60,
      image: "assets/navy_blue_shirt.png",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [Colors.black, Color(0xffB7B3AF), Color(0xff5983C0)],
      isAvailable: true,
    ),
    ProductModel(
      name: "Casual T-Shirt",
      price: 60,
      image: "assets/casual_shirt.png",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [Colors.black, Color(0xffB7B3AF), Color(0xff5983C0)],
      isAvailable: false,
    ),
    ProductModel(
      name: "Brown Jeans",
      price: 79,
      image: "assets/brown_jeans.png",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [Colors.black, Color(0xffB7B3AF), Color(0xff5983C0)],
      isAvailable: true,
    ),
    ProductModel(
      name: "Black T-Shirt",
      price: 60,
      image: "assets/black1.jpg",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [Colors.black, Color(0xffB7B3AF), Color(0xff5983C0)],
      isAvailable: true,
    ),
  ];

  final List<ProductModel> _pants = [
    ProductModel(
      name: "Black Jeans",
      price: 79,
      image: "assets/black.png",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [
        Colors.black,
        Colors.redAccent,
        Colors.greenAccent,
        Colors.amber,
        Colors.indigo,
      ],
      isAvailable: true,
    ),
    ProductModel(
      name: "White Jeans",
      price: 79,
      image: "assets/white_jeans.jpg",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [
        Colors.black,
        Colors.redAccent,
        Colors.greenAccent,
        Colors.amber,
        Colors.indigo,
      ],
      isAvailable: false,
    ),
    ProductModel(
      name: "Dark Blue Jeans",
      price: 79,
      image: "assets/blue_jeans.png",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [
        Colors.black,
        Colors.redAccent,
        Colors.greenAccent,
        Colors.amber,
        Colors.indigo,
      ],
      isAvailable: true,
    ),
    ProductModel(
      name: "Brown Jeans",
      price: 79,
      image: "assets/brown_jeans.png",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [
        Colors.black,
        Colors.redAccent,
        Colors.greenAccent,
        Colors.amber,
        Colors.indigo,
      ],
      isAvailable: true,
    ),
    ProductModel(
      name: "Light Blue Jeans",
      price: 80,
      image: "assets/light_blue_jeans.png",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [
        Colors.black,
        Colors.redAccent,
        Colors.greenAccent,
        Colors.amber,
        Colors.indigo,
      ],
      isAvailable: true,
    ),
  ];

  final List<ProductModel> _shoes = [
    ProductModel(
      name: "Green Nike Shoe",
      price: 120,
      image: "assets/1.png",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [
        Colors.black,
        Colors.redAccent,
        Colors.greenAccent,
        Colors.amber,
        Colors.indigo,
      ],
      isAvailable: true,
    ),
    ProductModel(
      name: "Purple Nike Shoe",
      price: 200,
      image: "assets/2.png",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [
        Colors.black,
        Colors.redAccent,
        Colors.greenAccent,
        Colors.amber,
        Colors.indigo,
      ],
      isAvailable: true,
    ),
    ProductModel(
      name: "Purple Nike Shoe",
      price: 200,
      image: "assets/3.png",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [
        Colors.black,
        Colors.redAccent,
        Colors.greenAccent,
        Colors.amber,
        Colors.indigo,
      ],
      isAvailable: false,
    ),
    ProductModel(
      name: "Purple Nike Shoe",
      price: 200,
      image: "assets/4.png",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [
        Colors.black,
        Colors.redAccent,
        Colors.greenAccent,
        Colors.amber,
        Colors.indigo,
      ],
      isAvailable: true,
    ),
    ProductModel(
      name: "Brown Nike Shoe",
      price: 200,
      image: "assets/nike.jpg",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      sizes: [5, 6, 7, 8, 9],
      colors: [
        Colors.black,
        Colors.redAccent,
        Colors.greenAccent,
        Colors.amber,
        Colors.indigo,
      ],
      isAvailable: true,
    ),
  ];

  void toggleFavorite(ProductModel product) {
    product.isFavorite = !product.isFavorite;
    notifyListeners();
  }

  List<ProductModel> get shirts => _shirts;
  List<ProductModel> get pants => _pants;
  List<ProductModel> get shoes => _shoes;
}
