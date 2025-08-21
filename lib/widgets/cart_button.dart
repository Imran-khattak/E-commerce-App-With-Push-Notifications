import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notifications/constants/theme.dart';

import 'package:notifications/provider/cart_animation_provider.dart';
import 'package:notifications/provider/cart_provider.dart';
import 'package:notifications/views/cart_screen.dart';
import 'package:provider/provider.dart';

class CartButton extends StatefulWidget {
  const CartButton({Key? key}) : super(key: key);

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  @override
  Widget build(BuildContext context) {
    final cartAnimationProvider = Provider.of<CartAnimationProvider>(context);

    return AddToCartAnimation(
      cartKey: cartAnimationProvider.getCartKey,
      height: 30,
      width: 30,
      opacity: 0.85,
      dragAnimation: const DragToCartAnimationOptions(rotation: true),
      jumpAnimation: const JumpAnimationOptions(),
      createAddToCartAnimation: (runAddToCartAnimation) {
        cartAnimationProvider.setAddToCartAnimation(runAddToCartAnimation);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
            child: AddToCartIcon(
              key: cartAnimationProvider.getCartKey,
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
                size: 30,
              ),
              badgeOptions: BadgeOptions(active: false),
            ),
          ),
          Positioned(
            top: -25,
            bottom: 5,
            right: -3,
            child: context.watch<CartProvider>().shoppingCart.isNotEmpty
                ? CircleAvatar(
                    backgroundColor: Utils.pacificblue,
                    radius: 10,
                    child: Text(
                      context
                          .watch<CartProvider>()
                          .shoppingCart
                          .length
                          .toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  )
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}
