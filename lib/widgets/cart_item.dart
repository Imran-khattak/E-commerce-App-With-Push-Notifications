import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:notifications/constants/theme.dart';

import 'package:notifications/model/cart_model.dart';
import 'package:notifications/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  final CartModel cartModel;
  const CartItem({super.key, required this.cartModel});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 15),
      child: Row(
        children: [
          // Icon(
          //   Icons.check_box_outline_blank,
          //   color: Utils.tide,
          //   size: 25,
          // ),
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              bool isSelected = cartProvider.isSelected(widget.cartModel.id);
              return GestureDetector(
                onTap: () {
                  cartProvider.toggleSelection(widget.cartModel.id);
                },
                child: Icon(
                  isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                  color: isSelected ? Utils.pacificblue : Utils.tide,
                  size: 25,
                ),
              );
            },
          ),
          SizedBox(width: size.width * 0.050),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              widget.cartModel.product.image,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: size.width * 0.060),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.cartModel.product.name,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: size.height * 0.020,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: size.height * 0.010),
              SizedBox(
                width: size.width - 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${widget.cartModel.product.price}",
                      style: GoogleFonts.poppins(
                        color: Utils.pacificblue,
                        fontSize: size.height * 0.018,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Utils.tide, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<CartProvider>().decrimentQty(
                                  widget.cartModel.id,
                                );
                              },
                              child: Icon(
                                Icons.remove,
                                color: Utils.pacificblue,
                                size: 15,
                              ),
                            ),
                            Text(
                              widget.cartModel.quantity.toString(),
                              style: GoogleFonts.poppins(
                                color: Utils.pacificblue,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<CartProvider>().incrementQty(
                                  widget.cartModel.id,
                                );
                              },
                              child: Icon(
                                Icons.add,
                                color: Utils.pacificblue,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
