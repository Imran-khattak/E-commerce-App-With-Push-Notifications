import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';

import 'package:notifications/animation/fade_animation.dart';
import 'package:notifications/constants/theme.dart';
import 'package:notifications/model/product_model.dart';
import 'package:notifications/provider/cart_provider.dart';
import 'package:notifications/provider/product_provider.dart';
import 'package:notifications/views/cart_screen.dart';
import 'package:notifications/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Color selectedColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context);

    // Responsive breakpoints
    bool isSmallScreen = size.width < 375;
    bool isLargeScreen = size.width > 414;

    // Responsive values
    double imageHeightRatio = isSmallScreen
        ? 0.50
        : (isLargeScreen ? 0.58 : 0.55);
    double horizontalPadding = isSmallScreen ? 16 : (isLargeScreen ? 24 : 20);
    double iconSize = isSmallScreen ? size.height * 0.030 : size.height * 0.035;
    double titleFontSize = isSmallScreen
        ? size.width * 0.040
        : size.width * 0.045;
    double priceFontSize = isSmallScreen
        ? size.width * 0.065
        : size.width * 0.07;
    double productNameSize = isSmallScreen
        ? size.width * 0.034
        : size.width * 0.037;
    double starSize = isSmallScreen ? size.height * 0.018 : size.height * 0.020;
    double buttonHeight = isSmallScreen
        ? size.height * 0.070
        : size.height * 0.075;
    double buttonWidth = isSmallScreen ? size.width * 0.38 : size.width * 0.40;
    double buttonFontSize = isSmallScreen
        ? size.width * 0.035
        : size.width * 0.040;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Utils.maincolor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                    ),
                    child: Image.asset(
                      widget.product.image,
                      height: size.height * imageHeightRatio,
                      width: size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.055,
                    right: size.width * 0.030,
                    left: size.width * 0.030,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: iconSize,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            'Product',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CartScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.white,
                                  size: iconSize,
                                ),
                              ),
                            ),
                            Positioned(
                              top: -8,
                              right: -2,
                              child:
                                  context
                                      .watch<CartProvider>()
                                      .shoppingCart
                                      .isNotEmpty
                                  ? CircleAvatar(
                                      backgroundColor: Utils.pacificblue,
                                      radius: isSmallScreen ? 8 : 10,
                                      child: Text(
                                        context
                                            .watch<CartProvider>()
                                            .shoppingCart
                                            .length
                                            .toString(),
                                        style: GoogleFonts.poppins(
                                          fontSize: isSmallScreen ? 8 : 10,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  widget.product.isAvailable
                      ? Positioned(
                          bottom: -25,
                          right: size.width * 0.045,
                          child: FadeAnimation(
                            2,
                            Container(
                              height: isSmallScreen ? 45 : 50,
                              width: isSmallScreen ? 45 : 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Utils.shadee,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Utils.shadee, Utils.shadee],
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                    offset: Offset(4.0, 4.0),
                                  ),
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                    offset: Offset(-4.0, -4.0),
                                  ),
                                ],
                              ),
                              child: LikeButton(
                                isLiked: widget.product.isFavorite,
                                onTap: (bool isLiked) async {
                                  productProvider.toggleFavorite(
                                    widget.product,
                                  );
                                  return !isLiked;
                                },
                                animationDuration: const Duration(
                                  milliseconds: 1000,
                                ),
                                circleColor: const CircleColor(
                                  start: Color(0xFFFF5722),
                                  end: Color(0xFFF44336),
                                ),
                                bubblesColor: const BubblesColor(
                                  dotPrimaryColor: Color(0xFFFFC107),
                                  dotSecondaryColor: Color(0xFFFF9800),
                                  dotThirdColor: Color(0xFFFF5722),
                                  dotLastColor: Color(0xFFF44336),
                                ),
                                likeBuilder: (bool isLiked) {
                                  return Icon(
                                    isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: isSmallScreen ? 25 : 30,
                                    color: isLiked
                                        ? Colors.redAccent
                                        : Colors.redAccent,
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: size.height * 0.030),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: FadeAnimation(
                  2,
                  Text(
                    "\$${widget.product.price}",
                    style: GoogleFonts.poppins(
                      color: Utils.pacificblue,
                      fontSize: priceFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 8,
                ),
                child: FadeAnimation(
                  2,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Text(
                          widget.product.name,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: productNameSize,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        flex: 2,
                        child: Wrap(
                          spacing: 2,
                          children: [
                            Icon(
                              Icons.star,
                              color: Utils.pacificblue,
                              size: starSize,
                            ),
                            Icon(
                              Icons.star,
                              color: Utils.pacificblue,
                              size: starSize,
                            ),
                            Icon(
                              Icons.star,
                              color: Utils.pacificblue,
                              size: starSize,
                            ),
                            Icon(
                              Icons.star_border_outlined,
                              color: Utils.pacificblue,
                              size: starSize,
                            ),
                            Icon(
                              Icons.star_outline_outlined,
                              color: Utils.pacificblue,
                              size: starSize,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.020),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: FadeAnimation(
                  2,
                  Text(
                    "Color options",
                    style: GoogleFonts.poppins(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w500,
                      fontSize: isSmallScreen ? 14 : 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.010),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: FadeAnimation(
                  2,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(widget.product.colors!.length, (
                        index,
                      ) {
                        Color color = widget.product.colors![index];
                        double colorSize = isSmallScreen ? 22 : 25;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColor = color;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            width: colorSize,
                            height: colorSize,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: selectedColor == color
                                    ? Utils.pacificblue
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.020),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: FadeAnimation(
                  2,
                  Text(
                    "Description",
                    style: GoogleFonts.poppins(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w500,
                      fontSize: isSmallScreen ? 14 : 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.010),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: FadeAnimation(
                  2,
                  Text(
                    widget.product.desc,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: isSmallScreen ? 12 : 14,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.040),
              widget.product.isAvailable
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                      ),
                      child: FadeAnimation(
                        2,
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              context.read<CartProvider>().addToCart(
                                widget.product,
                              );
                              showTopSnackBar(context);
                            },
                            child: Container(
                              height: buttonHeight,
                              width: buttonWidth,
                              decoration: BoxDecoration(
                                color: Utils.pacificblue,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Utils.pacificblue.withValues(
                                      alpha: 0.3,
                                    ),
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: isSmallScreen ? 18 : 20,
                                  ),
                                  SizedBox(width: size.width * 0.010),
                                  Text(
                                    "Add to cart",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: buttonFontSize,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: size.height * 0.020),
            ],
          ),
        ),
      ),
    );
  }
}
